import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/features/session/presentation/start_session.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/presentation/widgets/template_list_card.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/empty_state.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/screen_header.dart';

/// `emerald-600` — "Done" button in manage mode.
const Color _emerald600 = Color(0xFF059669);

class TemplatesScreen extends ConsumerStatefulWidget {
  const TemplatesScreen({super.key});

  @override
  ConsumerState<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends ConsumerState<TemplatesScreen> {
  final _searchController = TextEditingController();
  String _search = '';
  bool _manageMode = false;
  String? _confirmDeleteId;

  /// Local working order during manage mode (smooth drag without waiting for
  /// the server refetch).
  List<Template> _ordered = const [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _enterManage(List<Template> all) {
    setState(() {
      _manageMode = true;
      _ordered = List.of(all);
      _search = '';
      _searchController.clear();
      _confirmDeleteId = null;
    });
  }

  void _exitManage() {
    setState(() => _manageMode = false);
    AppToast.showSuccess(context, t.templates.list.savedChanges);
  }

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    setState(() {
      var to = newIndex;
      if (to > oldIndex) to -= 1;
      final item = _ordered.removeAt(oldIndex);
      _ordered.insert(to, item);
    });
    try {
      await ref
          .read(templatesControllerProvider.notifier)
          .reorder(_ordered.map((t) => t.id).toList(growable: false));
    } on Object {
      if (mounted) {
        AppToast.showError(context, t.templates.list.reorderError);
      }
    }
  }

  Future<void> _toggleActive(Template template) async {
    final next = !template.isActive;
    setState(() {
      _ordered = _ordered
          .map((e) => e.id == template.id ? e.copyWith(isActive: next) : e)
          .toList(growable: false);
    });
    try {
      await ref
          .read(templatesControllerProvider.notifier)
          .toggleActive(template.id, isActive: next);
    } on Object {
      if (mounted) AppToast.showError(context, t.templates.list.toggleError);
    }
  }

  Future<void> _duplicate(String id) async {
    try {
      await ref.read(templatesControllerProvider.notifier).duplicate(id);
      if (mounted) AppToast.showSuccess(context, t.templates.list.duplicated);
    } on Object {
      if (mounted) AppToast.showError(context, t.templates.list.duplicateError);
    }
  }

  Future<void> _delete(String id) async {
    setState(() => _confirmDeleteId = null);
    try {
      await ref.read(templatesControllerProvider.notifier).delete(id);
      if (mounted) AppToast.showSuccess(context, t.templates.list.deleted);
    } on Object {
      if (mounted) AppToast.showError(context, t.templates.list.deleteError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final templates = ref.watch(templatesControllerProvider);

    return GlowScaffold(
      child: AsyncValueWidget<List<Template>>(
        value: templates,
        onRetry: () => ref.invalidate(templatesControllerProvider),
        data: (list) => _manageMode
            ? _ManageList(
                templates: _ordered,
                subtitle: _subtitle(list),
                onReorder: _onReorder,
                onToggle: _toggleActive,
                onDone: _exitManage,
              )
            : _NormalList(
                templates: list,
                subtitle: _subtitle(list),
                search: _search,
                searchController: _searchController,
                confirmDeleteId: _confirmDeleteId,
                onSearch: (v) => setState(() => _search = v),
                onRefresh: () =>
                    ref.read(templatesControllerProvider.notifier).refresh(),
                onStart: (t) => startTemplateSession(context, ref, t.id),
                onEdit: (t) => context.push(Routes.templateEdit(t.id)),
                onDetails: (t) => context.push(Routes.templateDetail(t.id)),
                onDuplicate: (t) => _duplicate(t.id),
                onRequestDelete: (t) => setState(() => _confirmDeleteId = t.id),
                onDelete: (t) => _delete(t.id),
                onNew: () => context.push(Routes.templateNew),
                onManage: () => _enterManage(list),
              ),
      ),
    );
  }

  String _subtitle(List<Template> list) {
    final active = list.where((t) => t.isActive).length;
    if (_manageMode) {
      return t.templates.list.subtitleManage(n: active, total: list.length);
    }
    return t.templates.list.subtitleActive(n: active);
  }
}

/// Program page header: title + subtitle (via [ScreenHeader]) and right-aligned
/// actions (Manage / New, or Done in manage mode).
class _ProgramHeader extends StatelessWidget {
  const _ProgramHeader({required this.subtitle, required this.actions});

  final String subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ScreenHeader(
            title: t.templates.list.title,
            subtitle: subtitle,
          ),
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          // Equal-width actions, sized to the widest: `IntrinsicWidth` asks
          // the row for its natural width, and two `Expanded` children split
          // it evenly. Matching the labels by hand would only work in the
          // language it was tuned for — "Gérer"/"Créer" happen to be the same
          // length, "Gestionar"/"Crear" do not.
          child: IntrinsicWidth(
            child: Row(
              children: [
                for (var i = 0; i < actions.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(child: actions[i]),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Small chip-button for header actions. Filled (background, with the
/// brand's halo) or outline variant.
class _HeaderChip extends StatelessWidget {
  const _HeaderChip({
    required this.icon,
    required this.label,
    required this.foreground,
    required this.onTap,
    this.background,
    this.border,
    this.halo = false,
  });

  final IconData icon;
  final String label;
  final Color foreground;
  final VoidCallback onTap;
  final Color? background;
  final Color? border;
  final bool halo;

  @override
  Widget build(BuildContext context) {
    final glow = Theme.of(context).colorScheme.glow;
    return Pressable(
      onTap: onTap,
      scale: 0.94,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadius.controlSm),
          border: border != null ? Border.all(color: border!) : null,
          boxShadow: halo
              ? [
                  BoxShadow(
                    color: glow.withValues(alpha: 0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        // Centred rather than min-width: the chip is stretched to the
        // widest of the pair, so its content has to sit in the middle of
        // the box instead of hugging the left edge.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 15, color: foreground),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Normal mode ─────────────────────────────────────────────────────────────

class _NormalList extends StatelessWidget {
  const _NormalList({
    required this.templates,
    required this.subtitle,
    required this.search,
    required this.searchController,
    required this.confirmDeleteId,
    required this.onSearch,
    required this.onRefresh,
    required this.onStart,
    required this.onEdit,
    required this.onDetails,
    required this.onDuplicate,
    required this.onRequestDelete,
    required this.onDelete,
    required this.onNew,
    required this.onManage,
  });

  final List<Template> templates;
  final String subtitle;
  final String search;
  final TextEditingController searchController;
  final String? confirmDeleteId;
  final ValueChanged<String> onSearch;
  final Future<void> Function() onRefresh;
  final ValueChanged<Template> onStart;
  final ValueChanged<Template> onEdit;
  final ValueChanged<Template> onDetails;
  final ValueChanged<Template> onDuplicate;
  final ValueChanged<Template> onRequestDelete;
  final ValueChanged<Template> onDelete;
  final VoidCallback onNew;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final header = _ProgramHeader(
      subtitle: subtitle,
      actions: [
        if (templates.isNotEmpty) ...[
          _HeaderChip(
            icon: LucideIcons.slidersHorizontal,
            label: t.templates.list.manage,
            foreground: onSurface,
            border: onSurface.withValues(alpha: 0.12),
            onTap: onManage,
          ),
        ],
        _HeaderChip(
          icon: LucideIcons.plus,
          label: t.templates.list.newAction,
          foreground: scheme.onPrimary,
          background: scheme.primary,
          halo: true,
          onTap: onNew,
        ),
      ],
    );

    // No templates at all.
    if (templates.isEmpty) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          header,
          const SizedBox(height: 60),
          EmptyState(
            icon: LucideIcons.dumbbell,
            title: t.templates.list.emptyTitle,
            message: t.templates.list.emptyMessage,
            actionLabel: t.templates.list.emptyAction,
            onAction: onNew,
          ),
        ],
      );
    }

    final active = templates.where((t) => t.isActive).toList(growable: false);

    // Templates exist but none are in the program.
    if (active.isEmpty) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          header,
          const SizedBox(height: 60),
          EmptyState(
            icon: LucideIcons.dumbbell,
            title: t.templates.list.emptyActiveTitle,
            message: t.templates.list.emptyActiveMessage,
            actionLabel: t.templates.list.emptyActiveAction,
            onAction: onManage,
          ),
        ],
      );
    }

    final q = search.trim().toLowerCase();
    final filtered = active
        .where((t) => q.isEmpty || t.name.toLowerCase().contains(q))
        .toList(growable: false);

    final stagger = StaggeredList();
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          header,
          const SizedBox(height: 16),
          _SearchBar(controller: searchController, onChanged: onSearch),
          const SizedBox(height: 16),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Center(
                child: Text(
                  t.templates.list.noResult,
                  style: AppText.body.copyWith(color: scheme.textTertiary),
                ),
              ),
            )
          else
            for (final template in filtered)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: stagger.wrap(
                  TemplateListCard(
                    template: template,
                    manageMode: false,
                    confirmingDelete: confirmDeleteId == template.id,
                    onStart: () => onStart(template),
                    onEdit: () => onEdit(template),
                    onDetails: () => onDetails(template),
                    onDuplicate: () => onDuplicate(template),
                    onRequestDelete: () => onRequestDelete(template),
                    onDelete: () => onDelete(template),
                    onToggleActive: () {},
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: scheme.controlSurface,
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: scheme.textTertiary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: scheme.primary,
              style: TextStyle(fontSize: 14, color: onSurface),
              decoration: InputDecoration(
                isCollapsed: true,
                filled: false,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: t.templates.list.searchHint,
                hintStyle: AppText.body.copyWith(color: scheme.textTertiary),
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return Pressable(
                onTap: () {
                  controller.clear();
                  onChanged('');
                },
                scale: 0.85,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    LucideIcons.x,
                    size: 18,
                    color: scheme.textSecondary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Manage mode (reorder + activation) ──────────────────────────────────────

class _ManageList extends StatelessWidget {
  const _ManageList({
    required this.templates,
    required this.subtitle,
    required this.onReorder,
    required this.onToggle,
    required this.onDone,
  });

  final List<Template> templates;
  final String subtitle;
  final void Function(int, int) onReorder;
  final ValueChanged<Template> onToggle;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      buildDefaultDragHandles: false,
      header: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProgramHeader(
              subtitle: subtitle,
              actions: [
                _HeaderChip(
                  icon: LucideIcons.check,
                  label: t.common.actions.done,
                  foreground: Colors.white,
                  background: _emerald600,
                  onTap: onDone,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const _ManageHint(),
          ],
        ),
      ),
      itemCount: templates.length,
      onReorder: onReorder,
      proxyDecorator: (child, index, animation) =>
          Material(color: Colors.transparent, child: child),
      itemBuilder: (context, i) {
        final t = templates[i];
        return Padding(
          key: ValueKey(t.id),
          padding: const EdgeInsets.only(bottom: 12),
          child: TemplateListCard(
            template: t,
            manageMode: true,
            confirmingDelete: false,
            onStart: () {},
            onEdit: () {},
            onDetails: () {},
            onDuplicate: () {},
            onRequestDelete: () {},
            onDelete: () {},
            onToggleActive: () => onToggle(t),
            dragHandle: ReorderableDragStartListener(
              index: i,
              child: Container(
                width: 44,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: Icon(
                  LucideIcons.gripVertical,
                  size: 20,
                  color: Theme.of(context).colorScheme.glow,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ManageHint extends StatelessWidget {
  const _ManageHint();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final glow = scheme.glow;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: glow.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: glow.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.slidersHorizontal, size: 16, color: glow),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t.templates.list.manageHint,
              style: AppText.caption.copyWith(color: scheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/session/presentation/start_session.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/presentation/widgets/template_list_card.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/muscle_group_l10n.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/async_value_widget.dart';
import 'package:repster/shared/widgets/edge_bleed.dart';
import 'package:repster/shared/widgets/empty_state.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/muscle_group_visuals.dart';
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
  MuscleGroup? _tagFilter;
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
      _tagFilter = null;
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
                tagFilter: _tagFilter,
                searchController: _searchController,
                confirmDeleteId: _confirmDeleteId,
                onSearch: (v) => setState(() => _search = v),
                onTagFilter: (g) =>
                    setState(() => _tagFilter = _tagFilter == g ? null : g),
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
          child: Row(mainAxisSize: MainAxisSize.min, children: actions),
        ),
      ],
    );
  }
}

/// Small chip-button for header actions (avoids ButtonStyleButton in the AppBar
/// toolbar). Filled (background) or outline variant.
class _HeaderChip extends StatelessWidget {
  const _HeaderChip({
    required this.icon,
    required this.label,
    required this.foreground,
    required this.onTap,
    this.background,
    this.border,
  });

  final IconData icon;
  final String label;
  final Color foreground;
  final VoidCallback onTap;
  final Color? background;
  final Color? border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background ?? Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.controlSm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            border: border != null ? Border.all(color: border!) : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: foreground),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ],
          ),
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
    required this.tagFilter,
    required this.searchController,
    required this.confirmDeleteId,
    required this.onSearch,
    required this.onTagFilter,
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
  final MuscleGroup? tagFilter;
  final TextEditingController searchController;
  final String? confirmDeleteId;
  final ValueChanged<String> onSearch;
  final ValueChanged<MuscleGroup> onTagFilter;
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
          const SizedBox(width: 8),
        ],
        _HeaderChip(
          icon: LucideIcons.plus,
          label: t.templates.list.newAction,
          foreground: scheme.onPrimary,
          background: scheme.primary,
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
        .where((t) {
          final matchesSearch = q.isEmpty || t.name.toLowerCase().contains(q);
          final matchesTag = tagFilter == null || t.tags.contains(tagFilter);
          return matchesSearch && matchesTag;
        })
        .toList(growable: false);

    final usedTags = [
      for (final g in MuscleGroup.values)
        if (active.any((t) => t.tags.contains(g))) g,
    ];

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          header,
          const SizedBox(height: 16),
          _SearchBar(controller: searchController, onChanged: onSearch),
          if (usedTags.isNotEmpty) ...[
            const SizedBox(height: 12),
            _FilterPills(
              usedTags: usedTags,
              selected: tagFilter,
              onSelect: onTagFilter,
            ),
          ],
          const SizedBox(height: 16),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Center(
                child: Text(
                  t.templates.list.noResult,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ),
            )
          else
            for (var i = 0; i < filtered.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child:
                    TemplateListCard(
                          template: filtered[i],
                          manageMode: false,
                          confirmingDelete: confirmDeleteId == filtered[i].id,
                          onStart: () => onStart(filtered[i]),
                          onEdit: () => onEdit(filtered[i]),
                          onDetails: () => onDetails(filtered[i]),
                          onDuplicate: () => onDuplicate(filtered[i]),
                          onRequestDelete: () => onRequestDelete(filtered[i]),
                          onDelete: () => onDelete(filtered[i]),
                          onToggleActive: () {},
                        )
                        .animate(delay: (i * 50).ms)
                        .fadeIn(duration: 300.ms)
                        .slideY(
                          begin: 0.06,
                          end: 0,
                          curve: Curves.easeOutCubic,
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
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: onSurface.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.search,
            size: 18,
            color: onSurface.withValues(alpha: 0.45),
          ),
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
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return GestureDetector(
                onTap: () {
                  controller.clear();
                  onChanged('');
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    LucideIcons.x,
                    size: 18,
                    color: onSurface.withValues(alpha: 0.45),
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

class _FilterPills extends StatelessWidget {
  const _FilterPills({
    required this.usedTags,
    required this.selected,
    required this.onSelect,
  });

  final List<MuscleGroup> usedTags;
  final MuscleGroup? selected;
  final ValueChanged<MuscleGroup> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: EdgeBleed(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: usedTags.length + 1,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            if (i == 0) {
              return _Pill(
                label: t.common.all,
                active: selected == null,
                onTap: () {
                  if (selected != null) onSelect(selected!);
                },
              );
            }
            final g = usedTags[i - 1];
            return _Pill(
              label: '${g.emoji} ${g.localizedLabel}',
              active: selected == g,
              accent: g.accent,
              onTap: () => onSelect(g),
            );
          },
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.active,
    required this.onTap,
    this.accent,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Color bg;
    final Color fg;
    final Color border;
    if (active && accent != null) {
      bg = accent!.withValues(alpha: 0.15);
      fg = accent!;
      border = accent!.withValues(alpha: 0.6);
    } else if (active) {
      bg = scheme.primary;
      fg = scheme.onPrimary;
      border = scheme.primary;
    } else {
      bg = scheme.onSurface.withValues(alpha: 0.04);
      fg = scheme.onSurface.withValues(alpha: 0.6);
      border = scheme.onSurface.withValues(alpha: 0.10);
    }
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: border),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: fg,
            ),
          ),
        ),
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
                  color: Theme.of(context).colorScheme.primary,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.slidersHorizontal, size: 16, color: scheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t.templates.list.manageHint,
              style: TextStyle(
                fontSize: 12,
                color: scheme.primary.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/core/text/fold_accents.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/core/theme/app_text.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/l10n/fluent_emoji_l10n.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';
import 'package:repster/shared/widgets/pressable.dart';
import 'package:repster/shared/widgets/session_mark.dart';

/// Opens the session picture picker over the closed Fluent catalogue and
/// resolves with the pick, or `null` when dismissed.
///
/// A glass sheet, like every picker in the app: the search keeps the keyboard
/// focus, the grid below scrolls by family, a tap picks and closes. Search
/// matches the translated name, the family and the English key, accents and
/// case folded ("feu" and "fire" both find the flame).
Future<FluentEmoji?> showEmojiPicker(
  BuildContext context, {
  required FluentEmoji selected,
}) {
  return showGlassSheet<FluentEmoji>(
    context,
    builder: (context) => _EmojiPickerSheet(selected: selected),
  );
}

class _EmojiPickerSheet extends StatefulWidget {
  const _EmojiPickerSheet({required this.selected});

  final FluentEmoji selected;

  @override
  State<_EmojiPickerSheet> createState() => _EmojiPickerSheetState();
}

class _EmojiPickerSheetState extends State<_EmojiPickerSheet> {
  final _query = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _query.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<FluentEmoji> _matches(String query) {
    final q = foldAccents(query.trim().toLowerCase());
    if (q.isEmpty) return FluentEmoji.all;
    return [
      for (final e in FluentEmoji.all)
        if (foldAccents(e.localizedLabel.toLowerCase()).contains(q) ||
            e.key.contains(q) ||
            foldAccents(e.group.localizedLabel.toLowerCase()).contains(q))
          e,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SizedBox(
          // Tall enough to browse without the sheet growing and shrinking
          // with every search; still under the glass sheet's own ceiling.
          height: height * 0.78,
          child: Column(
            children: [
              const SheetHandle(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 6, 20, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        t.templates.emojiPicker.title,
                        style: AppText.title.copyWith(
                          fontSize: 16,
                          color: scheme.textPrimary,
                        ),
                      ),
                    ),
                    _CloseButton(onTap: () => Navigator.of(context).maybePop()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                child: _SearchField(controller: _query, focusNode: _focus),
              ),
              Expanded(
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _query,
                  builder: (context, value, _) {
                    final shown = _matches(value.text);
                    if (shown.isEmpty) {
                      return Center(
                        child: Text(
                          t.templates.emojiPicker.noResults,
                          style: AppText.body.copyWith(
                            color: scheme.textTertiary,
                          ),
                        ),
                      );
                    }
                    return _EmojiGrid(
                      shown: shown,
                      selected: widget.selected,
                      onPick: (e) => Navigator.of(context).pop(e),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: scheme.controlSurface,
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(LucideIcons.search, size: 16, color: scheme.textTertiary),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                autocorrect: false,
                textInputAction: TextInputAction.search,
                style: AppText.body.copyWith(
                  fontSize: 15,
                  color: scheme.textPrimary,
                ),
                cursorColor: scheme.primary,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: t.templates.emojiPicker.searchHint,
                  hintStyle: AppText.body.copyWith(
                    fontSize: 15,
                    color: scheme.textTertiary,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox(width: 14);
                return Pressable(
                  onTap: controller.clear,
                  scale: 0.9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      LucideIcons.x,
                      size: 16,
                      color: scheme.textSecondary,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Grouped grid: one eyebrow per family that still has results, then its
/// cells. A sliver list keeps 400 tiles cheap to scroll.
class _EmojiGrid extends StatelessWidget {
  const _EmojiGrid({
    required this.shown,
    required this.selected,
    required this.onPick,
  });

  final List<FluentEmoji> shown;
  final FluentEmoji selected;
  final ValueChanged<FluentEmoji> onPick;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final slivers = <Widget>[];
    for (final group in FluentEmojiGroup.values) {
      final family = [
        for (final e in shown)
          if (e.group == group) e,
      ];
      if (family.isEmpty) continue;
      slivers
        ..add(
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                group.localizedLabel.toUpperCase(),
                style: AppText.sectionLabel.copyWith(
                  color: scheme.textTertiary,
                ),
              ),
            ),
          ),
        )
        ..add(
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 56,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => _EmojiCell(
                  emoji: family[i],
                  selected: family[i] == selected,
                  onTap: () => onPick(family[i]),
                ),
                childCount: family.length,
              ),
            ),
          ),
        );
    }
    slivers.add(const SliverPadding(padding: EdgeInsets.only(bottom: 20)));
    return CustomScrollView(slivers: slivers);
  }
}

/// The cell is the tile itself (no `SessionMark` inside: two concentric
/// rounded squares read as a mistake). Chosen = lit border and fill.
class _EmojiCell extends StatelessWidget {
  const _EmojiCell({
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  final FluentEmoji emoji;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final glow = scheme.glow;
    return Semantics(
      label: emoji.localizedLabel,
      selected: selected,
      child: Pressable(
        onTap: onTap,
        scale: 0.9,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected
                ? glow.withValues(alpha: 0.14)
                : scheme.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(
              color: selected
                  ? glow.withValues(alpha: 0.55)
                  : scheme.onSurface.withValues(alpha: 0.07),
            ),
          ),
          child: Center(child: FluentEmojiImage(emoji, size: 30)),
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Pressable(
      onTap: onTap,
      scale: 0.9,
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppRadius.controlSm),
          border: Border.all(color: onSurface.withValues(alpha: 0.08)),
        ),
        child: Icon(
          LucideIcons.x,
          size: 16,
          color: onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

/// The form control: the exact mark the cards will show, its name, and a
/// "change" affordance. Tapping opens [showEmojiPicker].
class EmojiField extends StatelessWidget {
  const EmojiField({
    required this.value,
    required this.accent,
    required this.onChanged,
    super.key,
  });

  final FluentEmoji value;

  /// Tint behind the mark: the first muscle group's, as on the cards.
  final Color accent;
  final ValueChanged<FluentEmoji> onChanged;

  Future<void> _open(BuildContext context) async {
    final picked = await showEmojiPicker(context, selected: value);
    if (picked != null && picked != value) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Pressable(
      onTap: () => _open(context),
      scale: 0.98,
      child: Container(
        height: 56,
        padding: const EdgeInsets.fromLTRB(8, 0, 14, 0),
        decoration: scheme.controlSurface,
        child: Row(
          children: [
            SessionMark(emoji: value, accent: accent, radius: 10),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value.localizedLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.body.copyWith(
                  fontSize: 15,
                  color: scheme.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              t.templates.emojiPicker.change,
              style: AppText.caption.copyWith(color: scheme.textSecondary),
            ),
            const SizedBox(width: 4),
            Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: scheme.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

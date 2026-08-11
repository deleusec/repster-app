import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// The pure key function, not the `exercise_identity` barrel: a widget has no
// business pulling in Supabase and Riverpod.
import 'package:repster/core/exercises/exercise_name_key.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/exercises/domain/catalog_exercise.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/util/format.dart';

/// "Exercise name" search field with live catalog autocompletion.
///
/// A real search field (magnifier + clear) above a flat results list laid
/// directly on the sheet. Results come from the exercise catalog (certified
/// "Repster" exercises + the user's own) via [search], debounced on input.
/// Matching is accent-insensitive and spans every alias/translation; when the
/// hit is an alias different from the localized name, it is shown as a
/// subtitle. Certified exercises carry a small "Repster" badge. [addLabel]
/// labels the create row ("Use" / "Add").
class ExerciseNameField extends StatefulWidget {
  const ExerciseNameField({
    required this.controller,
    required this.search,
    required this.onSelected,
    required this.onSubmit,
    required this.addLabel,
    this.onChanged,
    this.focusNode,
    this.collapseWhenUnfocused = false,
    this.minQueryChars = 0,
    this.autofocus = false,
    super.key,
  });

  final TextEditingController controller;

  /// Catalog search: maps the raw query to a ranked list of matches.
  final Future<List<CatalogExercise>> Function(String query) search;
  final ValueChanged<CatalogExercise> onSelected;
  final VoidCallback onSubmit;

  /// Fired on every text edit — lets an embedding form persist the raw name as
  /// the user types (in-sheet uses read the controller directly and omit it).
  final ValueChanged<String>? onChanged;
  final String addLabel;
  final FocusNode? focusNode;

  /// Inline mode: keep the results panel hidden unless the field has focus, so
  /// a filled field reads as a plain input. Sheets leave this off (results
  /// always visible).
  final bool collapseWhenUnfocused;

  /// Minimum characters before hitting the catalog. `0` (sheets) searches on
  /// every keystroke, incl. the empty query (browse the whole catalog); inline
  /// fields set this to avoid an RPC — and a proposals panel — on 0–1 chars.
  final int minQueryChars;
  final bool autofocus;

  @override
  State<ExerciseNameField> createState() => _ExerciseNameFieldState();
}

class _ExerciseNameFieldState extends State<ExerciseNameField> {
  static const _debounce = Duration(milliseconds: 220);

  List<CatalogExercise> _results = const [];
  bool _loading = false;
  Timer? _timer;
  FocusNode? _ownFocus;

  /// The trimmed query the current [_results] were fetched for — lets us tell
  /// "searched, nothing found" apart from "not searched yet" (so a focused
  /// inline field shows nothing rather than a premature "no match").
  String? _searchedQuery;

  /// Guards against out-of-order responses: only the latest request applies.
  int _reqId = 0;

  FocusNode get _focus => widget.focusNode ?? (_ownFocus ??= FocusNode());

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
    _focus.addListener(_onFocusChange);
    // Inline fields defer the first search until focus, so a filled card
    // doesn't fetch (and hide) a list it never shows.
    if (!widget.collapseWhenUnfocused) {
      _runSearch(widget.controller.text.trim());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.controller.removeListener(_onChanged);
    _focus.removeListener(_onFocusChange);
    _ownFocus?.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!mounted) return;
    // Just toggles the inline gate; no search on focus — proposals appear only
    // once the user actually types (see [_onChanged]).
    setState(() {});
  }

  void _onChanged() {
    setState(() {});
    widget.onChanged?.call(widget.controller.text);
    _timer?.cancel();
    _timer = Timer(_debounce, () => _runSearch(widget.controller.text.trim()));
  }

  Future<void> _runSearch(String query) async {
    // Below the minimum: skip the RPC and clear any stale proposals.
    if (query.length < widget.minQueryChars) {
      if (!mounted) return;
      setState(() {
        _results = const [];
        _loading = false;
        _searchedQuery = null;
      });
      return;
    }
    final req = ++_reqId;
    setState(() => _loading = true);
    try {
      final rows = await widget.search(query);
      if (!mounted || req != _reqId) return;
      setState(() {
        _results = rows;
        _loading = false;
        _searchedQuery = query;
      });
    } on Object {
      if (!mounted || req != _reqId) return;
      setState(() {
        _results = const [];
        _loading = false;
        _searchedQuery = query;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    final query = widget.controller.text.trim();
    final folded = foldAccents(query);
    // Compared on the identity key, not on the folded text: offering "create"
    // for a name the resolver would reuse anyway (`Machine  Dips` next to
    // `Machine Dips`) promises a new exercise the save would not make.
    final queryKey = exerciseNameKey(query);
    final exactMatch =
        query.isNotEmpty &&
        _results.any((e) => exerciseNameKey(e.displayName) == queryKey);
    // Inline fields only offer "create" once a search resolved for this exact
    // query, so nothing flashes before results are known. Sheets keep the
    // immediate behavior.
    final searched = _searchedQuery == query;
    final showCreate =
        query.isNotEmpty &&
        !exactMatch &&
        (!widget.collapseWhenUnfocused || searched);
    final hasText = widget.controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Search field ────────────────────────────────────────────────────
        TextField(
          controller: widget.controller,
          focusNode: _focus,
          autofocus: widget.autofocus,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) => widget.onSubmit(),
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: onSurface.withValues(alpha: 0.05),
            hintText: t.session.search.hint,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            prefixIcon: Icon(
              LucideIcons.search,
              size: 18,
              color: onSurface.withValues(alpha: 0.4),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
            ),
            suffixIcon: hasText
                ? IconButton(
                    onPressed: widget.controller.clear,
                    splashRadius: 18,
                    icon: Icon(
                      LucideIcons.x,
                      size: 16,
                      color: onSurface.withValues(alpha: 0.45),
                    ),
                  )
                : null,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
            ),
            border: _border(onSurface.withValues(alpha: 0.08)),
            enabledBorder: _border(onSurface.withValues(alpha: 0.08)),
            focusedBorder: _border(scheme.primary.withValues(alpha: 0.5)),
          ),
        ),

        // ── Results (flat on the sheet) ─────────────────────────────────────
        // TextFieldTapRegion: a tap on a result must not count as "outside" the
        // field. Without it the field unfocuses on pointer-down, and in inline
        // mode that hides the list before the row's onTap (pointer-up) fires —
        // so the selection is lost.
        TextFieldTapRegion(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: _buildResults(
              context,
              query: query,
              folded: folded,
              showCreate: showCreate,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResults(
    BuildContext context, {
    required String query,
    required String folded,
    required bool showCreate,
  }) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    // Inline mode: no proposals unless the field is focused.
    if (widget.collapseWhenUnfocused && !_focus.hasFocus) {
      return const SizedBox.shrink();
    }

    // Below the minimum query length: stay hidden (no RPC, no panel).
    if (query.length < widget.minQueryChars) return const SizedBox.shrink();

    final searched = _searchedQuery == query;
    // Typed enough but the debounced search hasn't resolved for this query yet:
    // show nothing rather than a stale/premature "no match".
    if (widget.collapseWhenUnfocused && !searched && _results.isEmpty) {
      return const SizedBox.shrink();
    }

    if (_loading && _results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 12, left: 4),
        child: Row(
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: onSurface.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              t.session.search.loading,
              style: TextStyle(
                fontSize: 13,
                color: onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      );
    }

    // Show the "no results" note only if the user typed something.
    final showEmpty = query.isNotEmpty && _results.isEmpty;
    if (!showCreate && !showEmpty && _results.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 268),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            if (showCreate)
              _CreateRow(
                label: widget.addLabel,
                name: query,
                onTap: widget.onSubmit,
              ),
            if (showEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 12,
                ),
                child: Text(
                  t.session.search.noMatch,
                  style: TextStyle(
                    fontSize: 13,
                    color: onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
            for (final e in _results)
              _ExerciseRow(
                exercise: e,
                foldedQuery: folded,
                onTap: () => widget.onSelected(e),
              ),
          ],
        ),
      ),
    );
  }

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppRadius.xl),
    borderSide: BorderSide(color: color),
  );
}

/// Builds a name's spans, highlighting the portion matching [foldedQuery]
/// (case- and accent-insensitive comparison).
///
/// Folding is **not** length-preserving — `ß`→`ss`, `œ`→`oe`, `ĳ`→`ij` each
/// grow by one, a combining mark disappears — so an offset found in the folded
/// cannot index the original. Every folded position is mapped back to the
/// character it came from, which is what keeps the highlight on the right
/// letters in a name like `Hüftstoß`.
List<TextSpan> _highlightSpans(
  String name,
  String foldedQuery,
  TextStyle base,
  TextStyle highlight,
) {
  if (foldedQuery.isEmpty) return [TextSpan(text: name, style: base)];
  final folded = StringBuffer();
  // folded offset → offset in `name`, plus a closing sentinel.
  final origin = <int>[];
  for (var i = 0; i < name.length; i++) {
    final piece = foldAccents(name[i]);
    folded.write(piece);
    origin.addAll(List.filled(piece.length, i));
  }
  origin.add(name.length);
  final idx = folded.toString().indexOf(foldedQuery);
  if (idx < 0) return [TextSpan(text: name, style: base)];
  final start = origin[idx];
  final end = origin[(idx + foldedQuery.length).clamp(0, origin.length - 1)];
  return [
    if (start > 0) TextSpan(text: name.substring(0, start), style: base),
    TextSpan(text: name.substring(start, end), style: highlight),
    if (end < name.length) TextSpan(text: name.substring(end), style: base),
  ];
}

/// Small "Repster" emblem marking a certified catalog exercise.
class _CertifiedBadge extends StatelessWidget {
  const _CertifiedBadge();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: t.session.search.certifiedBadge,
      child: Icon(LucideIcons.badgeCheck, size: 15, color: scheme.primary),
    );
  }
}

/// Round icon chip at the start of a row.
class _LeadingChip extends StatelessWidget {
  const _LeadingChip({required this.icon, required this.color, this.tint});

  final IconData icon;
  final Color color;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tint ?? onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}

/// "Create / use a new exercise" row.
class _CreateRow extends StatelessWidget {
  const _CreateRow({
    required this.label,
    required this.name,
    required this.onTap,
  });

  final String label;
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return _RowShell(
      onTap: onTap,
      leading: _LeadingChip(
        icon: LucideIcons.plus,
        color: scheme.primary,
        tint: scheme.primary.withValues(alpha: 0.14),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$label « '),
            TextSpan(
              text: name,
              style: TextStyle(fontWeight: FontWeight.w700, color: onSurface),
            ),
            const TextSpan(text: ' »'),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: scheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Row for a catalog exercise (certified or the user's own).
class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.exercise,
    required this.foldedQuery,
    required this.onTap,
  });

  final CatalogExercise exercise;
  final String foldedQuery;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final base = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: onSurface.withValues(alpha: 0.92),
    );
    final highlight = base.copyWith(
      fontWeight: FontWeight.w800,
      color: onSurface,
    );

    // Surface the matched alias/translation when it differs from the shown
    // name (e.g. typed "DC" → "Développé couché").
    final matched = exercise.matchedVia;
    final showMatched =
        matched != null &&
        matched.isNotEmpty &&
        foldAccents(matched) != foldAccents(exercise.displayName);

    return _RowShell(
      onTap: onTap,
      leading: _LeadingChip(
        icon: LucideIcons.dumbbell,
        color: onSurface.withValues(alpha: 0.7),
      ),
      trailing: exercise.isCertified ? const _CertifiedBadge() : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: _highlightSpans(
                exercise.displayName,
                foldedQuery,
                base,
                highlight,
              ),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (showMatched)
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                matched,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: onSurface.withValues(alpha: 0.45),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Shared shell for result rows: chip + content + trailing, with a rounded
/// highlight on tap. Ensures identical vertical rhythm.
class _RowShell extends StatelessWidget {
  const _RowShell({
    required this.leading,
    required this.child,
    required this.onTap,
    this.trailing,
  });

  final Widget leading;
  final Widget child;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              leading,
              const SizedBox(width: 12),
              Expanded(child: child),
              if (trailing != null) ...[const SizedBox(width: 10), trailing!],
            ],
          ),
        ),
      ),
    );
  }
}

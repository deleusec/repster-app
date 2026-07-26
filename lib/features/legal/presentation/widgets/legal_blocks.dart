/// Visual building blocks shared by the legal screens (privacy policy, terms
/// of use, account deletion).
///
/// They exist so the three documents stay visually identical: a tweak here
/// lands on all of them at once, which is how they drifted apart the last
/// time each screen carried its own private copy.
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [url] externally, swallowing failures into the log — a dead link in
/// a legal document should never take the screen down with it.
Future<void> openLegalUrl(String url) async {
  final uri = Uri.parse(url);
  try {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) log.w("Impossible d'ouvrir le lien : $url");
  } on Object catch (e, st) {
    log.e('Échec ouverture lien : $url', error: e, stackTrace: st);
  }
}

/// Spaced uppercase label (section / intro kicker).
TextStyle legalKickerStyle(BuildContext context, double alpha) => TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.8,
  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: alpha),
);

// ── Rich-text fragments ──────────────────────────────────────────────────────

/// Inline fragment of a rich paragraph, decoupled from its Flutter rendering
/// (handled by [Rich]).
sealed class Frag {
  const Frag();
}

/// Plain text; inherits the paragraph's base style.
class Txt extends Frag {
  const Txt(this.text);
  final String text;
}

/// Bold accent. Default is an 80% tint; with [full] set to `true` it uses the
/// full tint.
class Bold extends Frag {
  const Bold(this.text, {this.full = false});
  final String text;
  final bool full;
}

/// Tint emphasis without bold weight.
class Emph extends Frag {
  const Emph(this.text);
  final String text;
}

/// Tappable link, colored `primary` and underlined.
class Link extends Frag {
  const Link(this.label, this.url);
  final String label;
  final String url;
}

/// Rich paragraph (bold, emphasis, links). Manages the lifecycle of the links'
/// [TapGestureRecognizer]s.
class Rich extends StatefulWidget {
  const Rich(this.frags, {this.alpha = 0.65, super.key});

  final List<Frag> frags;
  final double alpha;

  @override
  State<Rich> createState() => _RichState();
}

class _RichState extends State<Rich> {
  /// One recognizer per link, created once (fragments are fixed).
  late final Map<Link, TapGestureRecognizer> _recognizers = {
    for (final frag in widget.frags)
      if (frag is Link)
        frag: (TapGestureRecognizer()..onTap = () => openLegalUrl(frag.url)),
  };

  @override
  void dispose() {
    for (final r in _recognizers.values) {
      r.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final baseColor = scheme.onSurface.withValues(alpha: widget.alpha);

    final spans = <InlineSpan>[];
    for (final frag in widget.frags) {
      switch (frag) {
        case Txt(:final text):
          spans.add(TextSpan(text: text));
        case Bold(:final text, :final full):
          spans.add(
            TextSpan(
              text: text,
              style: TextStyle(
                color: full
                    ? scheme.onSurface
                    : scheme.onSurface.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        case Emph(:final text):
          spans.add(
            TextSpan(
              text: text,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.8)),
            ),
          );
        case Link(:final label):
          spans.add(
            TextSpan(
              text: label,
              style: TextStyle(
                color: scheme.primary,
                decoration: TextDecoration.underline,
                decorationColor: scheme.primary,
              ),
              recognizer: _recognizers[frag],
            ),
          );
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      style: TextStyle(fontSize: 13, height: 1.55, color: baseColor),
    );
  }
}

// ── Layout blocks ────────────────────────────────────────────────────────────

/// Document title plus its one-line summary.
class LegalHeader extends StatelessWidget {
  const LegalHeader({required this.title, required this.subtitle, super.key});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: scheme.onSurface.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }
}

/// Intro card: "Last updated" label, date, and the document's preamble.
class LegalIntroCard extends StatelessWidget {
  const LegalIntroCard({
    required this.lastUpdated,
    required this.preamble,
    super.key,
  });

  final String lastUpdated;
  final List<Frag> preamble;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: scheme.translucentCard,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last updated', style: legalKickerStyle(context, 0.35)),
          const SizedBox(height: 12),
          Text(
            lastUpdated,
            style: TextStyle(
              fontSize: 14,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 12),
          Rich(preamble, alpha: 0.7),
        ],
      ),
    );
  }
}

/// Section: spaced uppercase label plus a translucent card holding the body.
class LegalSection extends StatelessWidget {
  const LegalSection({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: legalKickerStyle(context, 0.5)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: scheme.translucentCard,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

/// Sub-section: secondary title, body, and optional italic note.
class LegalSubSection extends StatelessWidget {
  const LegalSubSection({
    required this.title,
    required this.children,
    this.note,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 8),
        ...children,
        if (note != null) ...[
          const SizedBox(height: 8),
          ItalicNote(note!, alpha: 0.45),
        ],
      ],
    );
  }
}

/// Plain paragraph, without rich fragments.
class Prose extends StatelessWidget {
  const Prose(this.text, {this.alpha = 0.65, super.key});

  final String text;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        height: 1.55,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: alpha),
      ),
    );
  }
}

/// List bullet: `primary` dot plus text (plain or rich).
class ListItem extends StatelessWidget {
  const ListItem(String text, {super.key}) : _text = text, _frags = null;

  const ListItem.rich(List<Frag> frags, {super.key})
    : _text = null,
      _frags = frags;

  final String? _text;
  final List<Frag>? _frags;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final frags = _frags;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: frags != null ? Rich(frags) : Prose(_text!)),
        ],
      ),
    );
  }
}

/// Bordered info block with zebra-striped rows.
class LegalInfoBlock extends StatelessWidget {
  const LegalInfoBlock({required this.rows, super.key});

  final List<LegalInfoRow> rows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++)
            rows[i].build(
              context,
              odd: i.isEven, // first row striped (CSS :nth-child odd)
              last: i == rows.length - 1,
            ),
        ],
      ),
    );
  }
}

/// Row of a [LegalInfoBlock]: muted label plus value (text or link).
class LegalInfoRow {
  const LegalInfoRow({required this.label, required this.value, this.href});

  final String label;
  final String value;
  final String? href;

  Widget build(BuildContext context, {required bool odd, required bool last}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: odd ? scheme.onSurface.withValues(alpha: 0.02) : null,
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                  color: scheme.onSurface.withValues(alpha: 0.05),
                ),
              ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 2,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: scheme.onSurface.withValues(alpha: 0.4),
              ),
            ),
          ),
          if (href != null)
            GestureDetector(
              onTap: () => openLegalUrl(href!),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: scheme.primary,
                ),
              ),
            )
          else
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: scheme.onSurface.withValues(alpha: 0.75),
              ),
            ),
        ],
      ),
    );
  }
}

/// Subtle inset box for highlighted blocks.
class NoteBox extends StatelessWidget {
  const NoteBox({required this.child, this.padding = 16, super.key});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}

/// Amber-tinted callout for the clauses a reader must not skim — the health
/// disclaimer, above all.
class WarningBox extends StatelessWidget {
  const WarningBox({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    const tint = AppColors.accentAmber;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: tint.withValues(alpha: 0.22)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 1),
                child: Icon(LucideIcons.triangleAlert, size: 15, color: tint),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    color: tint,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

/// Italic note in a muted tint.
class ItalicNote extends StatelessWidget {
  const ItalicNote(this.text, {this.alpha = 0.4, super.key});

  final String text;
  final double alpha;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        height: 1.5,
        fontStyle: FontStyle.italic,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: alpha),
      ),
    );
  }
}

/// Subtle banner (in the user's language) noting the legal document exists
/// only in English. Show it only outside the EN locale.
class EnglishOnlyNote extends StatelessWidget {
  const EnglishOnlyNote({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.info,
            size: 15,
            color: scheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t.legal.onlyInEnglish,
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: scheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Centered, very subtle footer.
class LegalFooter extends StatelessWidget {
  const LegalFooter({required this.lastUpdated, super.key});

  final String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Repster · Aëvon · $lastUpdated',
        style: TextStyle(
          fontSize: 10,
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: 0.15),
        ),
      ),
    );
  }
}

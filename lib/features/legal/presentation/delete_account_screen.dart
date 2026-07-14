import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/logging/app_logger.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

/// Account-deletion instructions screen. Publicly reachable (see the router's
/// `_publicPaths`) so it can be used as the "account deletion URL" required by
/// the Google Play Store. Styled with the same design-system tokens as the
/// privacy policy screen.
class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  static const String _email = 'admin@aevon.studio';
  static const String _lastUpdated = 'July 14, 2026';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GlowScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
            children: [
              _NavBar(onBack: () => context.canPop() ? context.pop() : null),
              const SizedBox(height: 28),
              const Text(
                'Delete Your Account',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'How to request deletion of your Repster account and '
                'associated data.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: scheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              if (LocaleSettings.currentLocale != AppLocale.en) ...[
                const SizedBox(height: 16),
                const _EnglishOnlyNote(),
              ],
              const SizedBox(height: 28),

              const _Section(
                title: 'APPLICATION',
                children: [
                  _InfoBlock(
                    rows: [
                      _InfoRow(label: 'Application', value: 'Repster'),
                      _InfoRow(label: 'Developer', value: 'Aëvon'),
                      _InfoRow(
                        label: 'Contact',
                        value: _email,
                        href: 'mailto:$_email',
                      ),
                    ],
                  ),
                ],
              ),

              const _Section(
                title: 'HOW TO REQUEST DELETION',
                children: [
                  _Prose(
                    'To delete your account and all associated data, send us '
                    'a deletion request by email:',
                  ),
                  SizedBox(height: 16),
                  _Step(
                    number: 1,
                    frags: [
                      _Txt('Send an email to '),
                      _Link(_email, 'mailto:$_email'),
                      _Txt(
                        ' from the email address linked to your Repster '
                        'account.',
                      ),
                    ],
                  ),
                  _Step(
                    number: 2,
                    frags: [
                      _Txt('Use the subject line '),
                      _Bold('“Delete my account”', full: true),
                      _Txt('.'),
                    ],
                  ),
                  _Step(
                    number: 3,
                    frags: [
                      _Txt(
                        'We verify that the request comes from the account '
                        'owner, then permanently delete your account and '
                        'associated data within a maximum of ',
                      ),
                      _Bold('30 days', full: true),
                      _Txt('.'),
                    ],
                  ),
                  SizedBox(height: 12),
                  _NoteBox(
                    child: _Rich(alpha: 0.6, [
                      _Txt('You can also reach us directly at '),
                      _Link(_email, 'mailto:$_email'),
                      _Txt(' for any question about your data.'),
                    ]),
                  ),
                ],
              ),

              const _Section(
                title: 'DATA THAT IS DELETED',
                children: [
                  _Prose(
                    'When your account is deleted, the following data is '
                    'permanently removed:',
                  ),
                  SizedBox(height: 12),
                  _ListItem('Account data — email address'),
                  _ListItem(
                    'Profile data — name, avatar and fitness goal',
                  ),
                  _ListItem(
                    'Training data — workout templates, sessions, exercises '
                    'and history',
                  ),
                ],
              ),

              const _Section(
                title: 'DATA THAT IS RETAINED',
                children: [
                  _Prose(
                    'For legal and security reasons, a limited amount of data '
                    'is kept after deletion:',
                  ),
                  SizedBox(height: 12),
                  _InfoBlock(
                    rows: [
                      _InfoRow(
                        label: 'Authentication logs',
                        value: '90 rolling days',
                      ),
                      _InfoRow(
                        label: 'Anonymized analytics',
                        value: '13 months maximum',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _ItalicNote(
                    'Retained data is either required by law or fully '
                    'anonymized (aggregated statistics) and can no longer be '
                    'used to identify you.',
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Text(
                'Last updated: $_lastUpdated',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: scheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Shared visual building blocks (mirrors PrivacyScreen's style) ────────────

class _NavBar extends StatelessWidget {
  const _NavBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.controlSm),
          onTap: onBack,
          child: Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: onSurface.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppRadius.controlSm),
              border: Border.all(color: onSurface.withValues(alpha: 0.08)),
            ),
            child: Icon(
              LucideIcons.chevronLeft,
              size: 17,
              color: onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

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
          Text(title, style: _kickerStyle(context, 0.5)),
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

class _Prose extends StatelessWidget {
  const _Prose(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        height: 1.55,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
      ),
    );
  }
}

class _ItalicNote extends StatelessWidget {
  const _ItalicNote(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        height: 1.5,
        fontStyle: FontStyle.italic,
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
      ),
    );
  }
}

class _NoteBox extends StatelessWidget {
  const _NoteBox({required this.child});

  final Widget child;

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
      child: child,
    );
  }
}

/// Numbered step: `primary` badge plus rich text.
class _Step extends StatelessWidget {
  const _Step({required this.number, required this.frags});

  final int number;
  final List<_Frag> frags;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: _Rich(frags),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
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
          Expanded(child: _Prose(text)),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  const _InfoBlock({required this.rows});

  final List<_InfoRow> rows;

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
            rows[i]._build(
              context,
              odd: i.isEven,
              last: i == rows.length - 1,
            ),
        ],
      ),
    );
  }
}

class _InfoRow {
  const _InfoRow({required this.label, required this.value, this.href});

  final String label;
  final String value;
  final String? href;

  Widget _build(BuildContext context, {required bool odd, required bool last}) {
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
              onTap: () => _openUrl(href!),
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

class _EnglishOnlyNote extends StatelessWidget {
  const _EnglishOnlyNote();

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

// ── Rich-text fragments ──────────────────────────────────────────────────────

sealed class _Frag {
  const _Frag();
}

class _Txt extends _Frag {
  const _Txt(this.text);
  final String text;
}

class _Bold extends _Frag {
  const _Bold(this.text, {this.full = false});
  final String text;
  final bool full;
}

class _Link extends _Frag {
  const _Link(this.label, this.url);
  final String label;
  final String url;
}

class _Rich extends StatefulWidget {
  const _Rich(this.frags, {this.alpha = 0.65});

  final List<_Frag> frags;
  final double alpha;

  @override
  State<_Rich> createState() => _RichState();
}

class _RichState extends State<_Rich> {
  late final Map<_Link, TapGestureRecognizer> _recognizers = {
    for (final frag in widget.frags)
      if (frag is _Link)
        frag: (TapGestureRecognizer()..onTap = () => _openUrl(frag.url)),
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
        case _Txt(:final text):
          spans.add(TextSpan(text: text));
        case _Bold(:final text, :final full):
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
        case _Link(:final label):
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

TextStyle _kickerStyle(BuildContext context, double alpha) => TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.8,
  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: alpha),
);

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  try {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) log.w("Impossible d'ouvrir le lien : $url");
  } on Object catch (e, st) {
    log.e('Échec ouverture lien : $url', error: e, stackTrace: st);
  }
}

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

/// Privacy policy screen, styled with the app's design-system tokens
/// (see [AppSurfaces], [AppRadius]).
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  static const String _lastUpdated = 'April 3, 2026';

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
              _NavBar(onBack: () => context.pop()),
              const SizedBox(height: 28),
              const Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'How your data is protected and used, '
                'in accordance with the GDPR.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: scheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              if (LocaleSettings.currentLocale != AppLocale.en) ...[
                const SizedBox(height: 16),
                _EnglishOnlyNote(),
              ],
              const SizedBox(height: 28),
              const _IntroCard(lastUpdated: _lastUpdated),
              const SizedBox(height: 28),

              const _Section(
                title: '1. Data controller',
                children: [
                  _Prose(
                    'The controller of your personal data '
                    'is:',
                  ),
                  SizedBox(height: 16),
                  _InfoBlock(
                    rows: [
                      _InfoRow(label: 'Entity', value: 'Aëvon'),
                      _InfoRow(label: 'Application', value: 'Repster'),
                      _InfoRow(label: 'Contact', value: 'admin@aevon.studio'),
                    ],
                  ),
                ],
              ),

              const _Section(
                title: '2. Data collected',
                children: [
                  _Prose(
                    'We only collect the data necessary for the '
                    'app to function. This data falls '
                    'into four categories:',
                  ),
                  SizedBox(height: 16),
                  _SubSection(
                    title: 'Account data',
                    children: [
                      _ListItem('Email address — login identifier'),
                      _ListItem(
                        'Password — stored encrypted and salted '
                        '(never in plain text)',
                      ),
                      _ListItem('Full name — displayed in the interface'),
                    ],
                  ),
                  SizedBox(height: 16),
                  _SubSection(
                    title: 'Profile data',
                    children: [
                      _ListItem(
                        'Fitness goal (strength, hypertrophy, endurance…)',
                      ),
                      _ListItem(
                        'Profile picture (avatar) — optional, provided and '
                        'stored only if you upload it',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _SubSection(
                    title: 'Training data',
                    note:
                        'This data is at the heart of the service. It '
                        'remains private and is never shared or '
                        'used for advertising purposes.',
                    children: [
                      _ListItem('Workout templates (name, exercises, order)'),
                      _ListItem(
                        'Exercise settings (sets, target reps, '
                        'tempo, rest time)',
                      ),
                      _ListItem(
                        'Completed sessions: exercises performed, number of '
                        'reps, load (kg), date and time',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _SubSection(
                    title: 'Technical data',
                    children: [
                      _ListItem(
                        'Anonymized usage data — via Vercel '
                        'Analytics (pages visited, device, country) with no '
                        'cookies or personal identifier',
                      ),
                      _ListItem(
                        'Authentication logs — login '
                        'timestamps managed by Supabase Auth',
                      ),
                    ],
                  ),
                ],
              ),

              const _Section(
                title: '3. Purposes and legal basis',
                children: [
                  _PurposeRow(
                    purpose: 'Provide the service',
                    detail:
                        'Create your account, store your workouts, '
                        'display your statistics.',
                    legal: 'Performance of the contract (Art. 6(1)(b) GDPR)',
                  ),
                  SizedBox(height: 12),
                  _PurposeRow(
                    purpose: 'Secure authentication',
                    detail:
                        'Manage your login, reset your '
                        'password.',
                    legal: 'Performance of the contract (Art. 6(1)(b) GDPR)',
                  ),
                  SizedBox(height: 12),
                  _PurposeRow(
                    purpose: 'Improving the app',
                    detail:
                        'Analyze which features are used (aggregated '
                        'and anonymized data).',
                    legal: 'Legitimate interest (Art. 6(1)(f) GDPR)',
                  ),
                  SizedBox(height: 12),
                  _PurposeRow(
                    purpose: 'Legal obligations',
                    detail:
                        'Meet applicable accounting, tax '
                        'and legal obligations.',
                    legal: 'Legal obligation (Art. 6(1)(c) GDPR)',
                  ),
                ],
              ),

              const _Section(
                title: '4. Hosting and sub-processors',
                children: [
                  _Prose(
                    'Your data is hosted exclusively with '
                    'trusted sub-processors that provide contractual '
                    'guarantees compliant with the GDPR:',
                  ),
                  SizedBox(height: 12),
                  _SubProcessorCard(
                    name: 'Supabase',
                    role: 'Database and authentication',
                    location: 'European Union (Frankfurt, Germany)',
                    link: 'https://supabase.com/privacy',
                    detail:
                        'All your account and training data is '
                        'stored on Supabase servers hosted in '
                        'the EU. Supabase is a signatory of the EU '
                        'Standard Contractual Clauses (SCC).',
                  ),
                  SizedBox(height: 12),
                  _SubProcessorCard(
                    name: 'Vercel',
                    role: 'Web app hosting',
                    location:
                        'Global regions (CDN), EU processing '
                        'available',
                    link: 'https://vercel.com/legal/privacy-policy',
                    detail:
                        'Vercel hosts the Repster frontend. Vercel '
                        'Analytics collects fully anonymized browsing '
                        'data, with no cookies and no '
                        'cross-site identifier.',
                  ),
                ],
              ),

              _Section(
                title: '5. Cookies and trackers',
                children: [
                  _NoteBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Repster does not use tracking cookies.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const _Rich(alpha: 0.6, [
                          _Txt('The Vercel Analytics tool is '),
                          _Emph('privacy-by-design'),
                          _Txt(
                            ': it sets no cookies, creates no '
                            'individual profile and performs no '
                            'cross-site tracking. The data collected '
                            '(page view, device, country) is aggregated '
                            'and cannot be used to identify you.',
                          ),
                        ]),
                        const SizedBox(height: 8),
                        const _Prose(
                          'Strictly necessary session cookies '
                          'are set by Supabase Auth to maintain your '
                          'authentication. These cookies cannot be '
                          'disabled because they are essential to the '
                          'operation of the service.',
                          alpha: 0.6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const _Section(
                title: '6. Retention period',
                children: [
                  _InfoBlock(
                    rows: [
                      _InfoRow(
                        label: 'Account and training data',
                        value: 'Until account deletion',
                      ),
                      _InfoRow(
                        label: 'Authentication logs',
                        value: '90 rolling days',
                      ),
                      _InfoRow(
                        label: 'Anonymized analytics data',
                        value: '13 months maximum',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _Rich([
                    _Txt(
                      'When your account is deleted, all of '
                      'your personal data (account, profile, '
                      'workouts) is permanently deleted within a '
                      'maximum of ',
                    ),
                    _Bold('30 days'),
                    _Txt(
                      '. Anonymized technical data (aggregated '
                      'logs) may be kept longer for '
                      'statistical purposes, but cannot be used to '
                      'identify you.',
                    ),
                  ]),
                ],
              ),

              const _Section(
                title: '7. Your rights',
                children: [
                  _Prose(
                    'In accordance with the GDPR, you have the following '
                    'rights over your data:',
                  ),
                  SizedBox(height: 12),
                  _RightRow(
                    name: 'Right of access',
                    detail:
                        'Obtain a copy of all the data '
                        'we hold about you.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to rectification',
                    detail:
                        'Correct inaccurate information directly '
                        'from your profile.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to erasure',
                    detail:
                        'Permanently delete your account and all your '
                        'data.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to portability',
                    detail:
                        'Receive your data in a structured, '
                        'readable format (JSON/CSV).',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to object',
                    detail:
                        'Object to processing based on our '
                        'legitimate interest (analytics).',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to restriction',
                    detail:
                        'Request the temporary suspension of the '
                        'processing of your data.',
                  ),
                  SizedBox(height: 16),
                  _NoteBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Rich(alpha: 0.6, [
                          _Txt('To exercise these rights, contact us at '),
                          _Link(
                            'admin@aevon.studio',
                            'mailto:admin@aevon.studio',
                          ),
                          _Txt('. We will respond within a maximum of '),
                          _Bold('30 days'),
                          _Txt('.'),
                        ]),
                        SizedBox(height: 8),
                        _Rich(alpha: 0.6, [
                          _Txt(
                            'You also have the right to lodge a '
                            'complaint with your local data protection '
                            'authority (in France, the ',
                          ),
                          _Bold('CNIL'),
                          _Txt(
                            ', the Commission Nationale de '
                            "l'Informatique et des Libertés): ",
                          ),
                          _Link('www.cnil.fr', 'https://www.cnil.fr'),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),

              const _Section(
                title: '8. Security',
                children: [
                  _Prose(
                    'We implement appropriate technical and '
                    'organizational measures to protect your data:',
                  ),
                  SizedBox(height: 12),
                  _ListItem.rich([
                    _Txt('Encryption of communications via '),
                    _Bold('HTTPS/TLS'),
                  ]),
                  _ListItem.rich([
                    _Txt('Passwords encrypted with '),
                    _Bold('bcrypt'),
                    _Txt(' — never stored in plain text'),
                  ]),
                  _ListItem.rich([
                    _Bold('Row Level Security (RLS)'),
                    _Txt(
                      ' enabled on all tables — you can only access '
                      'your own data',
                    ),
                  ]),
                  _ListItem(
                    'Database access restricted to authorized services '
                    'only',
                  ),
                  _ListItem.rich([
                    _Txt('Sessions authenticated with '),
                    _Bold('JWT'),
                    _Txt(' with automatic expiration'),
                  ]),
                  SizedBox(height: 12),
                  _ItalicNote(
                    'No system is infallible. In the event of a '
                    'data breach likely to affect your '
                    'rights, we undertake to inform you '
                    'within the legal time limits (72 h to the CNIL, '
                    'and without undue delay if the risk is high).',
                  ),
                ],
              ),

              const _Section(
                title: '9. Minors',
                children: [
                  _Rich([
                    _Txt('Repster is intended for users aged '),
                    _Bold('16 and over'),
                    _Txt(
                      '. We do not knowingly collect personal '
                      'data from minors under 16. If you '
                      'believe a minor has created an account, contact '
                      'us at ',
                    ),
                    _Link('admin@aevon.studio', 'mailto:admin@aevon.studio'),
                    _Txt(' so that we can delete the account.'),
                  ]),
                ],
              ),

              const _Section(
                title: '10. Changes to this policy',
                children: [
                  _Rich([
                    _Txt(
                      'We reserve the right to update this '
                      'privacy policy. In the event of a substantial '
                      'change affecting your rights, you will be '
                      'notified by email or by an in-app '
                      'notification at least ',
                    ),
                    _Bold('14 days before the changes take effect'),
                    _Txt('.'),
                  ]),
                  SizedBox(height: 8),
                  _Prose(
                    'The “Last updated” date at the top of this '
                    'page indicates the version in force. Continued '
                    'use of Repster after this date constitutes acceptance '
                    'of the updated policy.',
                  ),
                ],
              ),

              const _Section(
                title: '11. Contact',
                children: [
                  _InfoBlock(
                    rows: [
                      _InfoRow(
                        label: 'Data protection officer',
                        value: 'Aëvon',
                      ),
                      _InfoRow(
                        label: 'Email',
                        value: 'admin@aevon.studio',
                        href: 'mailto:admin@aevon.studio',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _Rich([
                    _Txt(
                      'For any question relating to this policy or to '
                      'your personal data, please do not hesitate to '
                      'contact us. We undertake to respond within ',
                    ),
                    _Bold('30 business days'),
                    _Txt('.'),
                  ]),
                ],
              ),

              const SizedBox(height: 8),
              const _Footer(lastUpdated: _lastUpdated),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: _NavButton(icon: LucideIcons.chevronLeft, onTap: onBack),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.controlSm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.controlSm),
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(AppRadius.controlSm),
            border: Border.all(color: onSurface.withValues(alpha: 0.08)),
          ),
          child: Icon(icon, size: 17, color: onSurface.withValues(alpha: 0.6)),
        ),
      ),
    );
  }
}

Future<void> _openUrl(String url) async {
  final uri = Uri.parse(url);
  try {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) log.w("Impossible d'ouvrir le lien : $url");
  } on Object catch (e, st) {
    log.e('Échec ouverture lien : $url', error: e, stackTrace: st);
  }
}

/// Inline fragment of a rich paragraph, decoupled from its Flutter rendering
/// (handled by [_Rich]).
sealed class _Frag {
  const _Frag();
}

/// Plain text; inherits the paragraph's base style.
class _Txt extends _Frag {
  const _Txt(this.text);
  final String text;
}

/// Bold accent. Default is an 80% tint; with [full] set to `true` it uses the
/// full tint.
class _Bold extends _Frag {
  const _Bold(this.text, {this.full = false});
  final String text;
  final bool full;
}

/// Tint emphasis without bold weight.
class _Emph extends _Frag {
  const _Emph(this.text);
  final String text;
}

/// Tappable link, colored `primary` and underlined.
class _Link extends _Frag {
  const _Link(this.label, this.url);
  final String label;
  final String url;
}

/// Intro card: "Last updated" label, date, and GDPR preamble.
class _IntroCard extends StatelessWidget {
  const _IntroCard({required this.lastUpdated});

  final String lastUpdated;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: scheme.translucentCard,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Last updated', style: _kickerStyle(context, 0.35)),
          const SizedBox(height: 12),
          Text(
            lastUpdated,
            style: TextStyle(
              fontSize: 14,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 12),
          const _Rich(alpha: 0.7, [
            _Txt('At '),
            _Bold('Aëvon', full: true),
            _Txt(
              ', we take the protection of your '
              'personal data very seriously. This privacy policy '
              'explains what data we collect in the ',
            ),
            _Bold('Repster', full: true),
            _Txt(
              ' app, how we use it, and what rights you have over '
              'it, in accordance with the GDPR.',
            ),
          ]),
        ],
      ),
    );
  }
}

/// Section: spaced uppercase label plus a translucent card holding the body.
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

/// Sub-section: secondary title, list, and optional italic note.
class _SubSection extends StatelessWidget {
  const _SubSection({required this.title, required this.children, this.note});

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
          _ItalicNote(note!, alpha: 0.45),
        ],
      ],
    );
  }
}

/// Plain paragraph, without rich fragments.
class _Prose extends StatelessWidget {
  const _Prose(this.text, {this.alpha = 0.65});

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

/// Rich paragraph (bold, emphasis, links). Manages the lifecycle of the links'
/// [TapGestureRecognizer]s.
class _Rich extends StatefulWidget {
  const _Rich(this.frags, {this.alpha = 0.65});

  final List<_Frag> frags;
  final double alpha;

  @override
  State<_Rich> createState() => _RichState();
}

class _RichState extends State<_Rich> {
  /// One recognizer per link, created once (fragments are fixed).
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
        case _Emph(:final text):
          spans.add(
            TextSpan(
              text: text,
              style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.8)),
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

/// List bullet: `primary` dot plus text (plain or rich).
class _ListItem extends StatelessWidget {
  const _ListItem(String text) : _text = text, _frags = null;

  const _ListItem.rich(List<_Frag> frags) : _text = null, _frags = frags;

  final String? _text;
  final List<_Frag>? _frags;

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
          Expanded(child: frags != null ? _Rich(frags) : _Prose(_text!)),
        ],
      ),
    );
  }
}

/// Bordered info block with zebra-striped rows.
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
              odd: i.isEven, // first row striped (CSS :nth-child odd)
              last: i == rows.length - 1,
            ),
        ],
      ),
    );
  }
}

/// Row of an [_InfoBlock]: muted label plus value (text or link).
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

/// Sub-processor card.
class _SubProcessorCard extends StatelessWidget {
  const _SubProcessorCard({
    required this.name,
    required this.role,
    required this.location,
    required this.link,
    required this.detail,
  });

  final String name;
  final String role;
  final String location;
  final String link;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface.withValues(alpha: 0.85),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurface.withValues(alpha: 0.45),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _openUrl(link),
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'Policy',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: scheme.primary.withValues(alpha: 0.7),
                      decoration: TextDecoration.underline,
                      decorationColor: scheme.primary.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.place_outlined,
                size: 13,
                color: scheme.onSurface.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            detail,
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
        ],
      ),
    );
  }
}

/// Purpose / legal-basis row.
class _PurposeRow extends StatelessWidget {
  const _PurposeRow({
    required this.purpose,
    required this.detail,
    required this.legal,
  });

  final String purpose;
  final String detail;
  final String legal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            purpose,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: scheme.onSurface.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            detail,
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: scheme.onSurface.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            legal,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: scheme.primary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}

/// GDPR right row: dot, name, and detail.
class _RightRow extends StatelessWidget {
  const _RightRow({required this.name, required this.detail});

  final String name;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.onSurface.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(AppRadius.control),
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Subtle inset box for highlighted blocks (cookies, exercising rights).
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
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}

/// Subtle banner (in the user's language) noting the legal document exists only
/// in English. Shown only outside the EN locale.
class _EnglishOnlyNote extends StatelessWidget {
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

/// Italic note in a muted tint.
class _ItalicNote extends StatelessWidget {
  const _ItalicNote(this.text, {this.alpha = 0.4});

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

/// Centered, very subtle footer.
class _Footer extends StatelessWidget {
  const _Footer({required this.lastUpdated});

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

/// Spaced uppercase label (section / intro kicker).
TextStyle _kickerStyle(BuildContext context, double alpha) => TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.8,
  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: alpha),
);

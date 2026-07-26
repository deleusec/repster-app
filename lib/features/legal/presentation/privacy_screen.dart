import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/legal/presentation/widgets/legal_blocks.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';

/// Privacy policy screen, styled with the app's design-system tokens
/// (see [AppSurfaces], [AppRadius]).
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  static const String _lastUpdated = 'July 26, 2026';

  /// Single contact address for every privacy request. Must stay in sync with
  /// `DeleteAccountScreen` and with the store listings.
  static const String _contactEmail = 'admin@aevon.studio';

  /// "Aëvon" is a trading name, not a company: the controller is the natural
  /// person behind the sole proprietorship, which GDPR Art. 13(1)(a) requires
  /// us to name.
  static const String _publisher =
      'Corentin Deleuse — entrepreneur individuel (EI)';
  static const String _siren = '992 545 517';

  static const String _postalAddress =
      '537 chemin de Boissy, 73420 Viviers-du-Lac, France';

  @override
  Widget build(BuildContext context) {
    return GlowScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
            children: [
              LegalNavBar(onBack: () => context.pop()),
              const SizedBox(height: 28),
              const LegalHeader(
                title: 'Privacy Policy',
                subtitle:
                    'How your data is protected and used, '
                    'in accordance with the GDPR.',
              ),
              if (LocaleSettings.currentLocale != AppLocale.en) ...[
                const SizedBox(height: 16),
                const EnglishOnlyNote(),
              ],
              const SizedBox(height: 28),
              const LegalIntroCard(
                lastUpdated: _lastUpdated,
                preamble: [
                  Txt('At '),
                  Bold('Aëvon', full: true),
                  Txt(
                    ', we take the protection of your '
                    'personal data very seriously. This privacy policy '
                    'explains what data we collect in ',
                  ),
                  Bold('Repster', full: true),
                  Txt(
                    ' — both the mobile app and the web app — how we use it, '
                    'and what rights you have over it, in accordance with '
                    'the GDPR.',
                  ),
                ],
              ),
              const SizedBox(height: 28),

              const LegalSection(
                title: '1. Data controller',
                children: [
                  Prose(
                    'The controller of your personal data '
                    'is:',
                  ),
                  SizedBox(height: 16),
                  LegalInfoBlock(
                    rows: [
                      LegalInfoRow(label: 'Controller', value: _publisher),
                      LegalInfoRow(label: 'Trading as', value: 'Aëvon'),
                      LegalInfoRow(label: 'SIREN', value: _siren),
                      LegalInfoRow(label: 'Address', value: _postalAddress),
                      LegalInfoRow(
                        label: 'Service',
                        value: 'Repster (iOS, Android, web)',
                      ),
                      LegalInfoRow(
                        label: 'Contact',
                        value: _contactEmail,
                        href: 'mailto:$_contactEmail',
                      ),
                    ],
                  ),
                ],
              ),

              const LegalSection(
                title: '2. Scope of this policy',
                children: [
                  Prose(
                    'Repster exists as a mobile app (iOS and Android) and as '
                    'a web app. Both share the same account and the same '
                    'database, so this policy covers them together. Where a '
                    'point applies to only one of them, it is marked as such.',
                  ),
                ],
              ),

              const LegalSection(
                title: '3. Data collected',
                children: [
                  Prose(
                    'We only collect the data necessary for the '
                    'service to function. This data falls '
                    'into five categories:',
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'Account data',
                    children: [
                      ListItem('Email address — login identifier'),
                      ListItem(
                        'Password — never stored in plain text; Supabase '
                        'Auth keeps only a salted hash of it, which we '
                        'cannot read',
                      ),
                      ListItem('Full name — displayed in the interface'),
                    ],
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'Profile data',
                    note:
                        'Everything in this category except the interface '
                        'language is optional. You can skip it at sign-up '
                        'and clear it at any time from your profile.',
                    children: [
                      ListItem(
                        'Fitness goal (strength, hypertrophy, endurance…)',
                      ),
                      ListItem(
                        'Body height (cm) and body weight (kg) — used to '
                        'contextualize your training statistics',
                      ),
                      ListItem(
                        'Date of birth — used to contextualize your training '
                        'statistics',
                      ),
                      ListItem(
                        'Profile picture (avatar) — provided and stored only '
                        'if you upload it (see section 10 on how it is '
                        'served)',
                      ),
                      ListItem(
                        'Interface language — so the app opens in the '
                        'language you picked',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'Training data',
                    note:
                        'This data is at the heart of the service. It '
                        'remains private and is never shared or '
                        'used for advertising purposes.',
                    children: [
                      ListItem('Workout templates (name, exercises, order)'),
                      ListItem(
                        'Exercise settings (sets, target reps, '
                        'tempo, rest time)',
                      ),
                      ListItem(
                        'Completed sessions: exercises performed, number of '
                        'reps, load (kg), date, time and duration',
                      ),
                      ListItem(
                        'Free-text notes you attach to a template, an '
                        'exercise or a session',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'Support data',
                    note:
                        'Support messages outlive your account, because they '
                        'are our record of the exchange. See section 8.',
                    children: [
                      ListItem(
                        'Messages sent through the in-app contact form: '
                        'name, email address, category and message body',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'Technical data',
                    children: [
                      ListItem(
                        'Authentication logs — login timestamps and IP '
                        'address, recorded by Supabase Auth',
                      ),
                      ListItem(
                        'Your login session, stored on your own device so '
                        'you stay signed in (see section 10)',
                      ),
                      ListItem(
                        'Web app only — anonymized usage data via Vercel '
                        'Analytics (pages visited, device type, country), '
                        'with no cookies and no personal identifier. The '
                        'mobile app contains no analytics at all.',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'What we never collect',
                    children: [
                      ListItem('Your precise or background location'),
                      ListItem('Your contacts, calendar or files'),
                      ListItem(
                        'Advertising identifiers (IDFA, Android '
                        'Advertising ID)',
                      ),
                      ListItem(
                        'Data from Apple Health, Google Fit or any other '
                        'health app — Repster does not connect to them',
                      ),
                      ListItem(
                        'Biometric data, and no third-party advertising, '
                        'tracking or crash-reporting SDK',
                      ),
                    ],
                  ),
                ],
              ),

              const LegalSection(
                title: '4. Device permissions (mobile app)',
                children: [
                  Prose(
                    'The mobile app asks for two permissions. Both are '
                    'optional: if you decline, the rest of the app keeps '
                    'working without the matching feature, and you can '
                    'change your mind at any time in your system settings.',
                  ),
                  SizedBox(height: 12),
                  _PurposeRow(
                    purpose: 'Camera and photo library',
                    detail:
                        'Only to set your profile picture. The image you '
                        'pick is uploaded as your avatar and nothing else — '
                        'we never browse or read the rest of your library.',
                    legal: 'Consent, revocable in your system settings',
                  ),
                  SizedBox(height: 12),
                  _PurposeRow(
                    purpose: 'Notifications',
                    detail:
                        'Only for the rest timer: the countdown and the '
                        'end-of-rest chime during a session. These '
                        'notifications are scheduled locally on your device. '
                        'There is no push token and nothing is sent to a '
                        'server.',
                    legal: 'Consent, revocable in your system settings',
                  ),
                ],
              ),

              const LegalSection(
                title: '5. Purposes and legal basis',
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
                    purpose: 'Personalize your statistics',
                    detail:
                        'Use the optional body height, body weight and date '
                        'of birth you chose to provide. Clearing these '
                        'fields in your profile withdraws your consent for '
                        'the future.',
                    legal:
                        'Consent (Art. 6(1)(a) GDPR, and Art. 9(2)(a) where '
                        'this qualifies as health data)',
                  ),
                  SizedBox(height: 12),
                  _PurposeRow(
                    purpose: 'Answer your support requests',
                    detail:
                        'Handle the messages you send through the contact '
                        'form and keep a record of the exchange.',
                    legal: 'Legitimate interest (Art. 6(1)(f) GDPR)',
                  ),
                  SizedBox(height: 12),
                  _PurposeRow(
                    purpose: 'Improving the web app',
                    detail:
                        'Analyze which pages are used, from aggregated and '
                        'anonymized data. Web app only.',
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

              const LegalSection(
                title: '6. Hosting, sub-processors and transfers',
                children: [
                  Prose(
                    'Your data is hosted exclusively with '
                    'trusted sub-processors that provide contractual '
                    'guarantees compliant with the GDPR:',
                  ),
                  SizedBox(height: 12),
                  _SubProcessorCard(
                    name: 'Supabase',
                    role: 'Database, authentication and avatar storage',
                    location: 'European Union (Paris, France)',
                    link: 'https://supabase.com/privacy',
                    detail:
                        'All your account, profile and training data is '
                        'stored on Supabase servers hosted in '
                        'the EU. Supabase is a signatory of the EU '
                        'Standard Contractual Clauses (SCC).',
                  ),
                  SizedBox(height: 12),
                  _SubProcessorCard(
                    name: 'Vercel',
                    role: 'Web app hosting and web analytics',
                    location:
                        'Global regions (CDN), EU processing '
                        'available',
                    link: 'https://vercel.com/legal/privacy-policy',
                    detail:
                        'Vercel serves the Repster web app and, on that web '
                        'app only, collects fully anonymized browsing data '
                        'with no cookies and no cross-site identifier. '
                        'Vercel plays no part in the mobile app.',
                  ),
                  SizedBox(height: 12),
                  _SubProcessorCard(
                    name: 'Apple and Google',
                    role: 'Mobile app distribution',
                    location: 'United States and global regions',
                    link: 'https://www.apple.com/legal/privacy/',
                    detail:
                        'The App Store and Google Play distribute the app '
                        'and, under their own privacy policies, collect '
                        'their own install, crash and usage statistics. We '
                        'receive only aggregated reports from them and '
                        'cannot identify you from those.',
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'Transfers outside the EU',
                    children: [
                      ListItem(
                        'Your account, profile and training data stays in '
                        'the European Union.',
                      ),
                      ListItem(
                        "Vercel's CDN may serve the web app from a region "
                        'outside the EU, and Apple and Google process '
                        'distribution data outside the EU.',
                      ),
                      ListItem(
                        'These transfers rely on the EU Standard '
                        'Contractual Clauses and, for US recipients, on the '
                        'EU–US Data Privacy Framework where the recipient '
                        'is certified under it.',
                      ),
                    ],
                  ),
                ],
              ),

              LegalSection(
                title: '7. Cookies and trackers',
                children: [
                  NoteBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Repster uses no tracking cookies and no '
                          'advertising trackers, on any platform.',
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
                        const Prose(
                          'The mobile app sets no cookies at all. Your '
                          'login session is kept in your device’s secure '
                          'storage (see section 10), not in a cookie.',
                          alpha: 0.6,
                        ),
                        const SizedBox(height: 8),
                        const Prose(
                          'On the web app, strictly necessary storage is '
                          'used by Supabase Auth to keep you signed in. It '
                          'cannot be disabled, because without it the '
                          'service cannot work.',
                          alpha: 0.6,
                        ),
                        const SizedBox(height: 8),
                        const Rich(alpha: 0.6, [
                          Txt(
                            'Still on the web app, the Vercel Analytics '
                            'tool is ',
                          ),
                          Emph('privacy-by-design'),
                          Txt(
                            ': it sets no cookies, creates no '
                            'individual profile and performs no '
                            'cross-site tracking. The data collected '
                            '(page view, device, country) is aggregated '
                            'and cannot be used to identify you.',
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),

              const LegalSection(
                title: '8. Retention period',
                children: [
                  LegalInfoBlock(
                    rows: [
                      LegalInfoRow(
                        label: 'Account, profile and training data',
                        value: 'Until account deletion',
                      ),
                      LegalInfoRow(
                        label: 'Profile picture',
                        value: 'Until you replace it or delete your account',
                      ),
                      LegalInfoRow(
                        label: 'Support messages',
                        value: '3 years after the last exchange',
                      ),
                      LegalInfoRow(
                        label: 'Authentication logs',
                        value: '12 months maximum',
                      ),
                      LegalInfoRow(
                        label: 'Anonymized analytics data (web)',
                        value: '13 months maximum',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Rich([
                    Txt(
                      'When your account is deleted, your account, profile '
                      'and training data is permanently deleted within a '
                      'maximum of ',
                    ),
                    Bold('30 days'),
                    Txt(
                      '. Anonymized technical data (aggregated '
                      'logs) may be kept longer for '
                      'statistical purposes, but cannot be used to '
                      'identify you.',
                    ),
                  ]),
                  SizedBox(height: 8),
                  Prose(
                    'One exception, and we would rather be plain about it: '
                    'messages sent through the contact form are our record '
                    'of the exchange, so they survive the deletion of your '
                    'account. They are detached from it, but the name, '
                    'email address and message body you wrote remain. Ask '
                    'us and we will delete those too.',
                  ),
                ],
              ),

              const LegalSection(
                title: '9. Your rights',
                children: [
                  Prose(
                    'In accordance with the GDPR, you have the following '
                    'rights over your data:',
                  ),
                  SizedBox(height: 12),
                  _RightRow(
                    name: 'Right of access',
                    detail:
                        'Obtain a copy of all the data we hold about you. '
                        'Email us and we send it to you.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to rectification',
                    detail:
                        'Correct inaccurate information directly '
                        'from your profile, at any time.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to erasure',
                    detail:
                        'Permanently delete your account and its data. '
                        'There is no in-app button yet: send us the '
                        'request by email and we handle it within 30 days. '
                        'The account-deletion page details the procedure.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to portability',
                    detail:
                        'Receive your data in a structured, readable '
                        'format (JSON). This is handled manually on '
                        'request — there is no self-service export yet.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to withdraw consent',
                    detail:
                        'Clear your body height, body weight or date of '
                        'birth from your profile whenever you want. '
                        'Withdrawal does not affect processing already '
                        'carried out.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to object',
                    detail:
                        'Object to processing based on our legitimate '
                        'interest — web analytics and support history.',
                  ),
                  SizedBox(height: 8),
                  _RightRow(
                    name: 'Right to restriction',
                    detail:
                        'Request the temporary suspension of the '
                        'processing of your data.',
                  ),
                  SizedBox(height: 16),
                  NoteBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Rich(alpha: 0.6, [
                          Txt('To exercise these rights, contact us at '),
                          Link(_contactEmail, 'mailto:$_contactEmail'),
                          Txt('. We will respond within '),
                          Bold('one month'),
                          Txt(
                            ', extendable by two further months if the '
                            'request is complex — in which case we will '
                            'tell you why within that first month '
                            '(Art. 12(3) GDPR).',
                          ),
                        ]),
                        SizedBox(height: 8),
                        Rich(alpha: 0.6, [
                          Txt(
                            'You also have the right to lodge a '
                            'complaint with your local data protection '
                            'authority (in France, the ',
                          ),
                          Bold('CNIL'),
                          Txt(
                            ', the Commission Nationale de '
                            "l'Informatique et des Libertés): ",
                          ),
                          Link('www.cnil.fr', 'https://www.cnil.fr'),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  Prose(
                    'Two commitments while we are here. We never sell your '
                    'data and never share it with third parties for '
                    'advertising. And we take no automated decision '
                    'producing legal effects about you, nor do we profile '
                    'you in the sense of Art. 22 GDPR.',
                  ),
                ],
              ),

              const LegalSection(
                title: '10. Security',
                children: [
                  Prose(
                    'We implement appropriate technical and '
                    'organizational measures to protect your data:',
                  ),
                  SizedBox(height: 12),
                  ListItem.rich([
                    Txt('Encryption of communications via '),
                    Bold('HTTPS/TLS'),
                  ]),
                  ListItem.rich([
                    Txt('Passwords hashed and salted with '),
                    Bold('bcrypt'),
                    Txt(' by Supabase Auth — never stored in plain text'),
                  ]),
                  ListItem.rich([
                    Bold('Row Level Security (RLS)'),
                    Txt(
                      ' enabled on every table holding your data — you can '
                      'only access your own rows',
                    ),
                  ]),
                  ListItem(
                    'Database access restricted to authorized services '
                    'only',
                  ),
                  ListItem.rich([
                    Txt('Sessions authenticated with '),
                    Bold('JWT'),
                    Txt(' with automatic expiration'),
                  ]),
                  ListItem.rich([
                    Txt(
                      'On mobile, your login session is stored encrypted '
                      'on the device itself — ',
                    ),
                    Bold('iOS Keychain'),
                    Txt(' and '),
                    Bold('Android Keystore'),
                  ]),
                  SizedBox(height: 16),
                  NoteBox(
                    child: Rich(alpha: 0.6, [
                      Bold('One deliberate exception: your avatar.'),
                      Txt(
                        ' So that it can be displayed quickly across the '
                        'app, your profile picture is served from a public '
                        'storage URL. Anyone who knows or guesses that URL '
                        'can view the image, without being signed in. '
                        'Please do not upload a picture you would not want '
                        'to be publicly reachable.',
                      ),
                    ]),
                  ),
                  SizedBox(height: 12),
                  ItalicNote(
                    'No system is infallible. In the event of a '
                    'data breach likely to affect your '
                    'rights, we undertake to inform you '
                    'within the legal time limits (72 h to the CNIL, '
                    'and without undue delay if the risk is high).',
                  ),
                ],
              ),

              const LegalSection(
                title: '11. Minors',
                children: [
                  Rich([
                    Txt('Repster is intended for users aged '),
                    Bold('16 and over'),
                    Txt(
                      '. We do not knowingly collect personal '
                      'data from minors under 16. If you '
                      'believe a minor has created an account, contact '
                      'us at ',
                    ),
                    Link(_contactEmail, 'mailto:$_contactEmail'),
                    Txt(' so that we can delete the account.'),
                  ]),
                ],
              ),

              const LegalSection(
                title: '12. Changes to this policy',
                children: [
                  Prose(
                    'We reserve the right to update this privacy policy. '
                    'In the event of a substantial change affecting your '
                    'rights, we will inform you by email or by an in-app '
                    'notice before the change takes effect.',
                  ),
                  SizedBox(height: 8),
                  Prose(
                    'The “Last updated” date at the top of this '
                    'page indicates the version in force. Continued '
                    'use of Repster after this date constitutes acceptance '
                    'of the updated policy.',
                  ),
                ],
              ),

              const LegalSection(
                title: '13. Contact',
                children: [
                  LegalInfoBlock(
                    rows: [
                      LegalInfoRow(
                        label: 'Data protection contact',
                        value: 'Aëvon',
                      ),
                      LegalInfoRow(
                        label: 'Email',
                        value: _contactEmail,
                        href: 'mailto:$_contactEmail',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Rich([
                    Txt(
                      'For any question relating to this policy or to '
                      'your personal data, please do not hesitate to '
                      'contact us. We undertake to respond within ',
                    ),
                    Bold('one month'),
                    Txt('.'),
                  ]),
                ],
              ),

              const SizedBox(height: 8),
              const LegalFooter(lastUpdated: _lastUpdated),
            ],
          ),
        ),
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
                onTap: () => openLegalUrl(link),
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

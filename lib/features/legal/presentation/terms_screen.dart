import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/legal/presentation/widgets/legal_blocks.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/back_nav_bar.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';

/// Terms of use, styled with the app's design-system tokens (see
/// [AppSurfaces], [AppRadius]) and the shared legal blocks.
///
/// Publicly reachable (see the router's `_publicPaths`): the sign-up screen
/// says the user accepts these terms, so they must be readable *before*
/// creating an account.
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  static const String _lastUpdated = 'July 26, 2026';

  /// Kept in sync with `PrivacyScreen` and `DeleteAccountScreen`.
  static const String _contactEmail = 'admin@aevon.studio';

  /// "Aëvon" is a trading name, not a company: the publisher is the natural
  /// person behind the sole proprietorship, which art. 6-III of the French
  /// LCEN requires us to name.
  static const String _publisher =
      'Corentin Deleuse — entrepreneur individuel (EI)';
  static const String _siren = '992 545 517';

  static const String _postalAddress =
      '537 chemin de Boissy, 73420 Viviers-du-Lac, France';

  // TODO(legal): before Repster earns anything, subscribe to an approved
  // consumer mediator and name it in section 16 — art. L.612-1 Code de la
  // consommation, enforced by a fine for failing to inform. Deliberately
  // deferred while the service is free; monetization is the trigger.

  @override
  Widget build(BuildContext context) {
    return GlowScaffold(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
            children: [
              BackNavBar(
                onBack: () => context.canPop() ? context.pop() : null,
              ),
              const SizedBox(height: 28),
              const LegalHeader(
                title: 'Terms of Use',
                subtitle:
                    'The rules of the deal between you and us when you '
                    'use Repster.',
              ),
              if (LocaleSettings.currentLocale != AppLocale.en) ...[
                const SizedBox(height: 16),
                const EnglishOnlyNote(),
              ],
              const SizedBox(height: 28),
              const LegalIntroCard(
                lastUpdated: _lastUpdated,
                preamble: [
                  Txt('These terms govern your use of '),
                  Bold('Repster', full: true),
                  Txt(
                    ', the training-log service published by ',
                  ),
                  Bold('Aëvon', full: true),
                  Txt(
                    ' as a mobile app (iOS and Android) and as a web app. '
                    'They are short on purpose, and we have tried to keep '
                    'them readable. Two sections deserve your attention '
                    'more than the others: ',
                  ),
                  Bold('6 (health and safety)'),
                  Txt(' and '),
                  Bold('10 (availability and your data)'),
                  Txt('.'),
                ],
              ),
              const SizedBox(height: 28),

              const LegalSection(
                title: '1. Purpose and acceptance',
                children: [
                  Prose(
                    'Repster lets you build workout templates, run live '
                    'training sessions from them, and review your '
                    'performance over time. These terms form the contract '
                    'between you and Aëvon for that service.',
                  ),
                  SizedBox(height: 8),
                  Prose(
                    'Creating an account means you accept these terms. If '
                    'you do not accept them, do not create an account and '
                    'do not use the service.',
                  ),
                ],
              ),

              const LegalSection(
                title: '2. Publisher',
                children: [
                  LegalInfoBlock(
                    rows: [
                      LegalInfoRow(label: 'Publisher', value: _publisher),
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
                      LegalInfoRow(
                        label: 'Hosting',
                        value: 'Supabase (EU) and Vercel',
                      ),
                    ],
                  ),
                ],
              ),

              const LegalSection(
                title: '3. Eligibility',
                children: [
                  Rich([
                    Txt('Repster is open to individuals aged '),
                    Bold('16 and over'),
                    Txt(
                      '. By creating an account you confirm that you meet '
                      'that age requirement and that you have the legal '
                      'capacity to enter into this contract.',
                    ),
                  ]),
                  SizedBox(height: 8),
                  Prose(
                    'The service is for personal, non-professional use. '
                    'Using it to coach or manage third parties requires our '
                    'prior written agreement.',
                  ),
                ],
              ),

              const LegalSection(
                title: '4. Your account',
                children: [
                  ListItem(
                    'One account per person. Give accurate information and '
                    'keep it up to date.',
                  ),
                  ListItem(
                    'Your login credentials are personal. Keep them secret '
                    'and do not share your account.',
                  ),
                  ListItem(
                    'You are responsible for everything done through your '
                    'account. Tell us immediately if you suspect it has '
                    'been compromised.',
                  ),
                  ListItem(
                    'Your training data is yours: nobody else can read it '
                    'through the service.',
                  ),
                ],
              ),

              const LegalSection(
                title: '5. The service',
                children: [
                  Rich([
                    Txt('Repster is currently provided '),
                    Bold('free of charge'),
                    Txt(
                      '. We may introduce paid features later; if we do, '
                      'we will say so clearly beforehand and no existing '
                      'feature will become payable without notice and '
                      'without your agreement.',
                    ),
                  ]),
                  SizedBox(height: 8),
                  Prose(
                    'The service evolves. We may add, change or withdraw '
                    'features to improve it, fix problems or keep it '
                    'maintainable. We will avoid removing anything you '
                    'depend on without warning.',
                  ),
                ],
              ),

              const LegalSection(
                title: '6. Health and safety',
                children: [
                  WarningBox(
                    title:
                        'Repster is a logbook, not a coach and not a '
                        'medical device.',
                    children: [
                      Prose(
                        'Nothing in the app — statistics, estimated 1RM, '
                        'trends, suggestions, rest timers — is medical '
                        'advice, a diagnosis, or a personalized training '
                        'prescription. The figures are computed from what '
                        'you type in, nothing more.',
                        alpha: 0.75,
                      ),
                      SizedBox(height: 8),
                      Prose(
                        'Strength training carries a risk of injury. You '
                        'train under your own responsibility and you alone '
                        'judge what your body can take on a given day.',
                        alpha: 0.75,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Prose(
                    'Consult a doctor or a qualified professional before '
                    'starting or resuming a training programme, and in '
                    'particular if you have a medical condition, are '
                    'recovering from an injury, are pregnant, or are '
                    'returning after a long break.',
                  ),
                  SizedBox(height: 8),
                  Prose(
                    'Stop immediately and seek medical attention if you '
                    'feel pain, dizziness, chest discomfort or shortness of '
                    'breath. An estimated one-rep max shown by the app is a '
                    'statistical estimate, never an instruction to attempt '
                    'that load.',
                  ),
                ],
              ),

              const LegalSection(
                title: '7. Acceptable use',
                children: [
                  Prose('You agree not to:'),
                  SizedBox(height: 12),
                  ListItem(
                    'Use the service unlawfully, or in a way that infringes '
                    "someone else's rights",
                  ),
                  ListItem(
                    'Attempt to access accounts, data or systems that are '
                    'not yours',
                  ),
                  ListItem(
                    'Disrupt, overload or probe the infrastructure, or '
                    'circumvent its security and rate limits',
                  ),
                  ListItem(
                    'Scrape, mass-extract or resell the content of the '
                    'service, including the certified exercise catalogue',
                  ),
                  ListItem(
                    'Upload unlawful, hateful, or infringing content — '
                    'including as a profile picture or in free-text notes',
                  ),
                  ListItem(
                    'Reverse-engineer, decompile or copy the app, except '
                    'where the law expressly allows it',
                  ),
                ],
              ),

              const LegalSection(
                title: '8. Your content',
                children: [
                  Prose(
                    'Your templates, sessions, notes and profile picture '
                    'remain yours. We claim no ownership over them.',
                  ),
                  SizedBox(height: 8),
                  Prose(
                    'You grant us only the limited, non-exclusive and '
                    'royalty-free licence needed to operate the service: '
                    'store your content, back it up, and display it back to '
                    'you across your devices. That licence lasts as long as '
                    'your account and ends when your content is deleted.',
                  ),
                  SizedBox(height: 8),
                  Prose(
                    'You are responsible for what you upload, and you '
                    'confirm you hold the rights to it — a profile picture '
                    'in particular.',
                  ),
                  SizedBox(height: 12),
                  NoteBox(
                    child: Rich(alpha: 0.6, [
                      Bold('One thing to keep in mind:'),
                      Txt(
                        ' your profile picture is served from a public '
                        'storage URL so the app can display it quickly. '
                        'Anyone who knows that URL can view the image. Do '
                        'not upload a picture you would not want publicly '
                        'reachable.',
                      ),
                    ]),
                  ),
                ],
              ),

              const LegalSection(
                title: '9. Our intellectual property',
                children: [
                  Prose(
                    'The app, its source code, its design, the Repster and '
                    'Aëvon names and logos, and the certified exercise '
                    'catalogue we maintain, belong to Aëvon and are '
                    'protected by intellectual property law.',
                  ),
                  SizedBox(height: 8),
                  Prose(
                    'These terms grant you a personal, non-transferable and '
                    'revocable right to use the app for its intended '
                    'purpose. They transfer no ownership of anything else.',
                  ),
                ],
              ),

              const LegalSection(
                title: '10. Availability and your data',
                children: [
                  Prose(
                    'We do our best to keep Repster available and your data '
                    'intact, but we provide the service as it is, with no '
                    'guarantee of uninterrupted availability. Maintenance, '
                    'incidents, or a failure at one of our hosting '
                    'providers can make it unavailable.',
                  ),
                  SizedBox(height: 12),
                  NoteBox(
                    child: Rich(alpha: 0.6, [
                      Bold('No backup guarantee.'),
                      Txt(
                        ' We take reasonable technical measures to protect '
                        'your data, but we do not guarantee that it can '
                        'always be recovered. If your training history '
                        'matters to you, ask us for an export from time to '
                        'time (see section 14) and keep your own copy.',
                      ),
                    ]),
                  ),
                ],
              ),

              const LegalSection(
                title: '11. Suspension and termination',
                children: [
                  LegalSubSection(
                    title: 'By you',
                    children: [
                      Prose(
                        'You can stop using the service at any time and '
                        'ask us to delete your account. The procedure is '
                        'described on the account-deletion page.',
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _InternalLink(
                    label: 'Read the account-deletion procedure',
                    route: Routes.deleteAccount,
                  ),
                  SizedBox(height: 16),
                  LegalSubSection(
                    title: 'By us',
                    children: [
                      Prose(
                        'We may suspend or close an account that seriously '
                        'or repeatedly breaches these terms, in particular '
                        'section 7, or that endangers the service or its '
                        'other users.',
                      ),
                      SizedBox(height: 8),
                      Prose(
                        'Except where a breach is serious enough to require '
                        'acting immediately, we will warn you first and let '
                        'you respond. When an account is closed, its data '
                        'is deleted under the conditions set out in the '
                        'privacy policy.',
                      ),
                    ],
                  ),
                ],
              ),

              const LegalSection(
                title: '12. Liability',
                children: [
                  Prose(
                    'We are liable for the damage that a failure on our '
                    'part directly causes you. We are not liable for:',
                  ),
                  SizedBox(height: 12),
                  ListItem(
                    'Injury or health consequences arising from your '
                    'training (see section 6)',
                  ),
                  ListItem(
                    'The consequences of data you entered incorrectly, or '
                    'of decisions you took based on the statistics shown',
                  ),
                  ListItem(
                    'Unavailability or data loss caused by a third party, '
                    'by your device, or by an event beyond our control',
                  ),
                  ListItem(
                    'Any indirect loss, such as loss of opportunity or '
                    'sporting performance',
                  ),
                  SizedBox(height: 12),
                  ItalicNote(
                    'Nothing in these terms excludes or limits liability '
                    'that the law does not allow us to exclude — in '
                    'particular for death or personal injury caused by our '
                    'negligence, for fraud, or under the mandatory '
                    'protections French consumer law gives you.',
                  ),
                ],
              ),

              const LegalSection(
                title: '13. App Store and Google Play',
                children: [
                  Prose(
                    'When you install the mobile app from a store, these '
                    'terms bind you and Aëvon only. Apple and Google are '
                    'not parties to them.',
                  ),
                  SizedBox(height: 12),
                  ListItem(
                    'Apple and Google have no obligation to provide '
                    'maintenance or support for the app',
                  ),
                  ListItem(
                    'Any claim about the app — conformity, defects, '
                    'third-party rights, product liability — must be '
                    'addressed to us, not to them',
                  ),
                  ListItem(
                    'Apple and its subsidiaries are third-party '
                    'beneficiaries of these terms and may enforce them '
                    'against you as such',
                  ),
                  ListItem(
                    'You confirm that you are not located in a country '
                    'subject to an embargo and that you appear on no '
                    'prohibited-party list',
                  ),
                  SizedBox(height: 12),
                  Prose(
                    'The rules of the store you installed the app from '
                    'apply on top of these terms.',
                  ),
                ],
              ),

              const LegalSection(
                title: '14. Personal data',
                children: [
                  Prose(
                    'How we collect and use your personal data, how long we '
                    'keep it, and the rights you have over it — including '
                    'access, erasure and export — are described in the '
                    'privacy policy, which forms part of this contract.',
                  ),
                  SizedBox(height: 12),
                  _InternalLink(
                    label: 'Read the privacy policy',
                    route: Routes.privacy,
                  ),
                ],
              ),

              const LegalSection(
                title: '15. Changes to these terms',
                children: [
                  Prose(
                    'We may update these terms, in particular to follow '
                    'changes in the service or in the law. For a '
                    'substantial change affecting your rights or '
                    'obligations, we will inform you by email or by an '
                    'in-app notice before it takes effect.',
                  ),
                  SizedBox(height: 8),
                  Prose(
                    'The “Last updated” date at the top of this page marks '
                    'the version in force. Continuing to use Repster after '
                    'that date means you accept the updated terms; if you '
                    'do not, you can close your account.',
                  ),
                ],
              ),

              const LegalSection(
                title: '16. Governing law and disputes',
                children: [
                  Prose(
                    'These terms are governed by French law. If you are a '
                    'consumer resident in another EU country, you keep the '
                    'protection of the mandatory rules of your own country.',
                  ),
                  SizedBox(height: 12),
                  Rich([
                    Txt('If something goes wrong, please '),
                    Bold('write to us first'),
                    Txt(' at '),
                    Link(_contactEmail, 'mailto:$_contactEmail'),
                    Txt(
                      ' — most problems are settled in a couple of emails, '
                      'and we would rather solve yours than argue about it.',
                    ),
                  ]),
                  SizedBox(height: 12),
                  Prose(
                    'Failing an amicable agreement, the dispute may be '
                    'brought before the competent courts.',
                  ),
                ],
              ),

              const LegalSection(
                title: '17. Contact',
                children: [
                  LegalInfoBlock(
                    rows: [
                      LegalInfoRow(label: 'Publisher', value: 'Aëvon'),
                      LegalInfoRow(
                        label: 'Email',
                        value: _contactEmail,
                        href: 'mailto:$_contactEmail',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Prose(
                    'A question about these terms, or about anything else? '
                    'Write to us — we answer.',
                  ),
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

/// Tappable row pointing at another in-app legal document. Unlike [Link],
/// which opens an external URL, this one navigates with go_router.
class _InternalLink extends StatelessWidget {
  const _InternalLink({required this.label, required this.route});

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.control),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.control),
        onTap: () => context.push(route),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppRadius.control),
            border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: scheme.primary,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 15,
                color: scheme.primary.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

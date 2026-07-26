import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:repster/features/legal/presentation/widgets/legal_blocks.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/back_nav_bar.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';

/// Account-deletion instructions screen. Publicly reachable (see the router's
/// `_publicPaths`) so it can be used as the "account deletion URL" required by
/// the Google Play Store. Styled with the same design-system tokens as the
/// privacy policy screen.
class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  static const String _email = 'admin@aevon.studio';
  static const String _lastUpdated = 'July 26, 2026';

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
              BackNavBar(
                onBack: () => context.canPop() ? context.pop() : null,
              ),
              const SizedBox(height: 28),
              const LegalHeader(
                title: 'Delete Your Account',
                subtitle:
                    'How to request deletion of your Repster account and '
                    'associated data.',
              ),
              if (LocaleSettings.currentLocale != AppLocale.en) ...[
                const SizedBox(height: 16),
                const EnglishOnlyNote(),
              ],
              const SizedBox(height: 28),

              const LegalSection(
                title: 'APPLICATION',
                children: [
                  LegalInfoBlock(
                    rows: [
                      LegalInfoRow(label: 'Application', value: 'Repster'),
                      LegalInfoRow(label: 'Developer', value: 'Aëvon'),
                      LegalInfoRow(
                        label: 'Contact',
                        value: _email,
                        href: 'mailto:$_email',
                      ),
                    ],
                  ),
                ],
              ),

              const LegalSection(
                title: 'HOW TO REQUEST DELETION',
                children: [
                  Prose(
                    'To delete your account and all associated data, send us '
                    'a deletion request by email:',
                  ),
                  SizedBox(height: 16),
                  _Step(
                    number: 1,
                    frags: [
                      Txt('Send an email to '),
                      Link(_email, 'mailto:$_email'),
                      Txt(
                        ' from the email address linked to your Repster '
                        'account.',
                      ),
                    ],
                  ),
                  _Step(
                    number: 2,
                    frags: [
                      Txt('Use the subject line '),
                      Bold('“Delete my account”', full: true),
                      Txt('.'),
                    ],
                  ),
                  _Step(
                    number: 3,
                    frags: [
                      Txt(
                        'We verify that the request comes from the account '
                        'owner, then permanently delete your account and '
                        'associated data within a maximum of ',
                      ),
                      Bold('30 days', full: true),
                      Txt('.'),
                    ],
                  ),
                  SizedBox(height: 12),
                  NoteBox(
                    child: Rich(alpha: 0.6, [
                      Txt('You can also reach us directly at '),
                      Link(_email, 'mailto:$_email'),
                      Txt(' for any question about your data.'),
                    ]),
                  ),
                ],
              ),

              const LegalSection(
                title: 'DATA THAT IS DELETED',
                children: [
                  Prose(
                    'When your account is deleted, the following data is '
                    'permanently removed:',
                  ),
                  SizedBox(height: 12),
                  ListItem('Account data — email address'),
                  ListItem(
                    'Profile data — name, avatar, fitness goal, and the '
                    'optional body height, body weight and date of birth',
                  ),
                  ListItem(
                    'Training data — workout templates, sessions, exercises '
                    'and history',
                  ),
                ],
              ),

              const LegalSection(
                title: 'DATA THAT IS RETAINED',
                children: [
                  Prose(
                    'For legal and security reasons, a limited amount of data '
                    'is kept after deletion:',
                  ),
                  SizedBox(height: 12),
                  LegalInfoBlock(
                    rows: [
                      LegalInfoRow(
                        label: 'Support messages',
                        value: '3 years after the last exchange',
                      ),
                      LegalInfoRow(
                        label: 'Authentication logs',
                        value: '12 months maximum',
                      ),
                      LegalInfoRow(
                        label: 'Anonymized analytics',
                        value: '13 months maximum',
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Prose(
                    'Messages you sent through the contact form are our '
                    'record of the exchange, so they outlive the account. '
                    'They are detached from it, but the name, email address '
                    'and message body remain. Ask us and we delete those '
                    'too.',
                  ),
                  SizedBox(height: 12),
                  ItalicNote(
                    'Everything else retained is either required by law or '
                    'fully anonymized (aggregated statistics) and can no '
                    'longer be used to identify you.',
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

/// Numbered step: `primary` badge plus rich text.
class _Step extends StatelessWidget {
  const _Step({required this.number, required this.frags});

  final int number;
  final List<Frag> frags;

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
              child: Rich(frags),
            ),
          ),
        ],
      ),
    );
  }
}

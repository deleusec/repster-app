import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/i18n/locale_sync.dart';
import 'package:repster/core/supabase/supabase_providers.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/core/theme/app_surfaces.dart';
import 'package:repster/features/settings/application/language_controller.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_drawer_sheet.dart';

/// Opens the app's language picker.
Future<void> showLanguagePicker(BuildContext context) => AppDrawerSheet.show(
  context,
  title: t.settings.language.title,
  child: const _LanguagePickerBody(),
);

/// Language name translated into the current language (exonym): e.g. in French,
/// German shows as "Allemand".
String _languageLabel(AppLocale locale) => switch (locale) {
  AppLocale.en => t.common.language.en,
  AppLocale.fr => t.common.language.fr,
  AppLocale.es => t.common.language.es,
  AppLocale.de => t.common.language.de,
  AppLocale.it => t.common.language.it,
};

class _LanguagePickerBody extends ConsumerWidget {
  const _LanguagePickerBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    // No stored preference => "system" option is checked.
    final storedCode = ref
        .watch(currentUserProvider)
        ?.userMetadata?[kLanguageMetaKey];
    final isSystem = storedCode is! String;
    final current = LocaleSettings.currentLocale;
    final controller = ref.read(languageControllerProvider);

    Future<void> pop() async {
      if (context.mounted) await Navigator.of(context).maybePop();
    }

    return DecoratedBox(
      decoration: scheme.translucentCard,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.card),
        // Material inside the clip so the rows' InkWell ink is clipped to the
        // rounded corners instead of bleeding onto the sheet's ancestor
        // Material.
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguageRow(
                label: t.settings.language.system,
                selected: isSystem,
                onTap: () async {
                  await controller.useSystemLanguage();
                  await pop();
                },
              ),
              for (final locale in AppLocale.values) ...[
                Divider(height: 1, color: scheme.hairline),
                _LanguageRow(
                  label: _languageLabel(locale),
                  selected: !isSystem && locale == current,
                  onTap: () async {
                    await controller.setLanguage(locale);
                    await pop();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final onSurface = scheme.onSurface;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  color: onSurface.withValues(alpha: selected ? 0.95 : 0.75),
                ),
              ),
            ),
            if (selected)
              Icon(LucideIcons.check, size: 18, color: scheme.primary),
          ],
        ),
      ),
    );
  }
}

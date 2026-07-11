import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/error/humanize_error.dart';
import 'package:repster/core/router/routes.dart';
import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/contact/application/contact_controller.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/animation/staggered_list.dart';
import 'package:repster/shared/widgets/app_button.dart';
import 'package:repster/shared/widgets/app_text_field.dart';
import 'package:repster/shared/widgets/form_error_box.dart';
import 'package:repster/shared/widgets/glow_scaffold.dart';
import 'package:repster/shared/widgets/icon_chip.dart';
import 'package:repster/shared/widgets/section_label.dart';

/// "Contact & feedback" screen: request-type selector, user info, message with
/// a character counter, then a confirmation view.
class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  static const int _maxMessage = 1000;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtl;
  late final TextEditingController _emailCtl;
  late final TextEditingController _messageCtl;

  _ContactCategory _category = _ContactCategory.general;
  int _messageLength = 0;
  bool _submitting = false;
  bool _success = false;
  String? _globalError;

  @override
  void initState() {
    super.initState();
    final u = ref.read(authControllerProvider).valueOrNull;
    final fallbackName = (u?.fullName?.trim().isNotEmpty ?? false)
        ? u!.fullName!.trim()
        : (u?.email.split('@').first ?? '');
    _nameCtl = TextEditingController(text: fallbackName);
    _emailCtl = TextEditingController(text: u?.email ?? '');
    _messageCtl = TextEditingController();
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _emailCtl.dispose();
    _messageCtl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _globalError = null;
    });
    try {
      await ref
          .read(contactControllerProvider.notifier)
          .submit(
            name: _nameCtl.text,
            email: _emailCtl.text,
            category: _category.id,
            message: _messageCtl.text,
          );
      if (!mounted) return;
      setState(() => _success = true);
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _globalError = humanizeAppError(e));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlowScaffold(
      child: _success
          ? _SuccessView(onBack: _goBack, category: _category)
          : _buildForm(context),
    );
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(Routes.settings);
    }
  }

  Widget _buildForm(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final stagger = StaggeredList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 40),
      children: [
        stagger.wrap(_NavBar(onBack: _goBack)),
        const SizedBox(height: 28),
        stagger.wrap(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.contact.header.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                t.contact.header.subtitle,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: scheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              stagger.wrap(SectionLabel(t.contact.sections.type)),
              const SizedBox(height: 12),
              stagger.wrap(_categoryGrid()),
              const SizedBox(height: 24),

              stagger.wrap(SectionLabel(t.contact.sections.yourInfo)),
              const SizedBox(height: 12),
              stagger.wrap(
                AppTextField(
                  controller: _nameCtl,
                  hint: t.contact.fields.nameHint,
                  prefixIcon: LucideIcons.user,
                  textInputAction: TextInputAction.next,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? t.contact.fields.nameRequired
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              stagger.wrap(
                AppTextField(
                  controller: _emailCtl,
                  hint: t.contact.fields.emailHint,
                  prefixIcon: LucideIcons.mail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  validator: (v) => (v == null || !v.contains('@'))
                      ? t.contact.fields.emailInvalid
                      : null,
                ),
              ),
              const SizedBox(height: 24),

              stagger.wrap(_messageHeader(scheme)),
              const SizedBox(height: 12),
              stagger.wrap(
                AppTextField(
                  controller: _messageCtl,
                  hint: _category.placeholder,
                  maxLines: 6,
                  minLines: 6,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(_maxMessage),
                  ],
                  onChanged: (v) => setState(() => _messageLength = v.length),
                  validator: (v) => (v == null || v.trim().length < 10)
                      ? t.contact.fields.messageTooShort
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              stagger.wrap(_CategoryHint(category: _category)),

              if (_globalError != null) ...[
                const SizedBox(height: 16),
                FormErrorBox(message: _globalError!),
              ],

              const SizedBox(height: 24),
              stagger.wrap(
                AppButton(
                  label: t.contact.submit,
                  icon: LucideIcons.send,
                  onPressed: _submitting ? null : _submit,
                  loading: _submitting,
                  expand: true,
                  size: AppButtonSize.lg,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _messageHeader(ColorScheme scheme) {
    final nearLimit = _messageLength > 900;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SectionLabel(t.contact.sections.message),
        Text(
          t.contact.counter(current: _messageLength, max: _maxMessage),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontFeatures: const [FontFeature.tabularFigures()],
            color: nearLimit
                ? scheme.primary.withValues(alpha: 0.7)
                : scheme.onSurface.withValues(alpha: 0.3),
          ),
        ),
      ],
    );
  }

  Widget _categoryGrid() {
    const items = _ContactCategory.values;
    Widget cell(_ContactCategory c) => Expanded(
      child: _CategoryButton(
        category: c,
        selected: _category == c,
        onTap: () => setState(() => _category = c),
      ),
    );
    return Column(
      children: [
        Row(
          children: [cell(items[0]), const SizedBox(width: 8), cell(items[1])],
        ),
        const SizedBox(height: 8),
        Row(
          children: [cell(items[2]), const SizedBox(width: 8), cell(items[3])],
        ),
      ],
    );
  }
}

/// Request type. [id] matches the constrained value of the
/// `contact_requests.category` column.
enum _ContactCategory {
  bug('bug', LucideIcons.bug, AppColors.accentRose),
  feature('feature', LucideIcons.lightbulb, AppColors.accentAmber),
  general('general', LucideIcons.messageCircle, AppColors.accentBlue),
  other('other', LucideIcons.ellipsis, AppColors.accentViolet);

  const _ContactCategory(this.id, this.icon, this.color);

  final String id;
  final IconData icon;
  final Color color;

  /// Translated label shown on the category button.
  String get label => switch (this) {
    _ContactCategory.bug => t.contact.categories.bug.label,
    _ContactCategory.feature => t.contact.categories.feature.label,
    _ContactCategory.general => t.contact.categories.general.label,
    _ContactCategory.other => t.contact.categories.other.label,
  };

  /// Concrete example injected into the message field.
  String get placeholder => switch (this) {
    _ContactCategory.bug => t.contact.categories.bug.placeholder,
    _ContactCategory.feature => t.contact.categories.feature.placeholder,
    _ContactCategory.general => t.contact.categories.general.placeholder,
    _ContactCategory.other => t.contact.categories.other.placeholder,
  };

  /// Hint shown below the field to guide what's worth writing.
  String get guidance => switch (this) {
    _ContactCategory.bug => t.contact.categories.bug.guidance,
    _ContactCategory.feature => t.contact.categories.feature.guidance,
    _ContactCategory.general => t.contact.categories.general.guidance,
    _ContactCategory.other => t.contact.categories.other.guidance,
  };

  /// Confirmation message tailored to the category after sending.
  String get successLine => switch (this) {
    _ContactCategory.bug => t.contact.categories.bug.successLine,
    _ContactCategory.feature => t.contact.categories.feature.successLine,
    _ContactCategory.general => t.contact.categories.general.successLine,
    _ContactCategory.other => t.contact.categories.other.successLine,
  };
}

/// Contextual hint below the message field: a small category-tinted icon plus
/// muted text explaining what's worth writing.
class _CategoryHint extends StatelessWidget {
  const _CategoryHint({required this.category});

  final _ContactCategory category;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(
              LucideIcons.info,
              size: 13,
              color: category.color.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              category.guidance,
              style: TextStyle(
                fontSize: 12,
                height: 1.45,
                color: scheme.onSurface.withValues(alpha: 0.45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final _ContactCategory category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.onSurface.withValues(alpha: selected ? 0.06 : 0.04),
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(
              color: selected
                  ? scheme.primary.withValues(alpha: 0.4)
                  : scheme.onSurface.withValues(alpha: 0.07),
            ),
          ),
          child: Row(
            children: [
              IconChip(
                icon: category.icon,
                color: category.color,
                size: 32,
                iconSize: 16,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  category.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurface.withValues(
                      alpha: selected ? 1 : 0.7,
                    ),
                  ),
                ),
              ),
              if (selected)
                Icon(LucideIcons.check, size: 16, color: scheme.primary),
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

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.onBack, required this.category});

  final VoidCallback onBack;
  final _ContactCategory category;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppRadius.sheet),
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Icon(
                LucideIcons.circleCheck,
                size: 36,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.contact.success.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                category.successLine,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: scheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              label: t.contact.success.back,
              onPressed: onBack,
              variant: AppButtonVariant.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

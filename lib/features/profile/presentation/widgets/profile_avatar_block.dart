import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:repster/core/theme/app_colors.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/i18n/translations.g.dart';
import 'package:repster/shared/widgets/app_action_sheet.dart';
import 'package:repster/shared/widgets/app_loading.dart';
import 'package:repster/shared/widgets/app_toast.dart';
import 'package:repster/shared/widgets/pressable.dart';

/// Tappable avatar: pick from camera or gallery, or remove it.
class ProfileAvatarBlock extends ConsumerStatefulWidget {
  const ProfileAvatarBlock({required this.user, super.key});

  final AuthUser user;

  @override
  ConsumerState<ProfileAvatarBlock> createState() => _AvatarBlockState();
}

class _AvatarBlockState extends ConsumerState<ProfileAvatarBlock> {
  bool _busy = false;

  Future<void> _pick(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? file;
    try {
      file = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
    } on Object {
      if (!mounted) return;
      AppToast.showError(context, t.profile.avatar.openError);
      return;
    }
    if (file == null) return;
    final bytes = await file.readAsBytes();
    await _upload(bytes);
  }

  Future<void> _upload(Uint8List bytes) async {
    setState(() => _busy = true);
    try {
      await ref.read(authControllerProvider.notifier).setAvatar(bytes);
      if (!mounted) return;
      AppToast.showSuccess(context, t.profile.avatar.updated);
    } on Object {
      if (!mounted) return;
      AppToast.showError(context, t.profile.avatar.saveError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _remove() async {
    setState(() => _busy = true);
    try {
      await ref.read(authControllerProvider.notifier).removeAvatar();
      if (!mounted) return;
      AppToast.showSuccess(context, t.profile.avatar.removed);
    } on Object {
      if (!mounted) return;
      AppToast.showError(context, t.profile.avatar.removeError);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openMenu() async {
    if (_busy) return;
    final hasAvatar = widget.user.avatarUrl != null;
    final choice = await AppActionSheet.show<_AvatarAction>(
      context,
      title: t.profile.avatar.sheetTitle,
      actions: [
        AppSheetAction(
          value: _AvatarAction.camera,
          label: t.profile.avatar.takePhoto,
          icon: LucideIcons.camera,
        ),
        AppSheetAction(
          value: _AvatarAction.gallery,
          label: t.profile.avatar.gallery,
          icon: LucideIcons.image,
        ),
        if (hasAvatar)
          AppSheetAction(
            value: _AvatarAction.delete,
            label: t.profile.avatar.remove,
            icon: LucideIcons.trash2,
            isDestructive: true,
          ),
      ],
    );
    switch (choice) {
      case _AvatarAction.camera:
        await _pick(ImageSource.camera);
      case _AvatarAction.gallery:
        await _pick(ImageSource.gallery);
      case _AvatarAction.delete:
        await _remove();
      case null:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final avatarUrl = widget.user.avatarUrl;
    return Pressable(
      onTap: _openMenu,
      scale: 0.95,
      child: SizedBox(
        width: 96,
        height: 96,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 96,
              height: 96,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xxl),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [scheme.primary, const Color(0xFF7F1D1D)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.glow.withValues(alpha: 0.30),
                    blurRadius: 28,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: avatarUrl != null
                  ? Image.network(
                      avatarUrl,
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _initial(),
                    )
                  : _initial(),
            ),
            if (_busy)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                  ),
                  child: const Center(
                    child: AppSpinner(
                      size: 22,
                      color: Colors.white,
                      stroke: 2.5,
                    ),
                  ),
                ),
              )
            else
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: scheme.surface, width: 2),
                  ),
                  child: const Icon(
                    LucideIcons.camera,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _initial() {
    final name = widget.user.firstName.trim();
    final char = name.isNotEmpty
        ? name.substring(0, 1)
        : (widget.user.email.isEmpty ? '?' : widget.user.email.substring(0, 1));
    return Text(
      char.toUpperCase(),
      style: const TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
    );
  }
}

enum _AvatarAction { camera, gallery, delete }

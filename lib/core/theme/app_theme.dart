import 'package:flutter/material.dart';

import 'package:repster/core/theme/app_colors.dart';

/// The app's text font — bundled Manrope (see `pubspec.yaml`), the same family
/// the PWA uses. Bundled (not fetched) so it renders identically offline and
/// with no flash of a fallback font.
const _fontFamily = 'Manrope';

/// The app's global theme — mirrors the PWA's design system (shadcn + tailwind
/// with the `rose` preset, dark mode by default).
///
/// See `repster-pwa/app/globals.css` for the source of truth on tokens (colors,
/// radii). Its CSS variables are in oklch and approximated in sRGB in
/// [AppColors].
class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(_lightScheme, Brightness.light);
  static ThemeData dark() => _build(_darkScheme, Brightness.dark);

  static const _lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.roseLight,
    onPrimary: AppColors.roseOnPrimary,
    secondary: Color(0xFFF4F4F5),
    onSecondary: Color(0xFF252525),
    error: AppColors.roseLight,
    onError: AppColors.roseOnPrimary,
    surface: AppColors.lightBackground,
    onSurface: AppColors.lightForeground,
    surfaceContainerLowest: AppColors.lightBackground,
    surfaceContainerLow: Color(0xFFFAFAFA),
    surfaceContainer: AppColors.lightCard,
    surfaceContainerHigh: Color(0xFFF5F5F5),
    surfaceContainerHighest: Color(0xFFEFEFEF),
    onSurfaceVariant: AppColors.lightMutedForeground,
    outline: AppColors.lightBorder,
    outlineVariant: AppColors.lightBorder,
  );

  static const _darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.roseDark,
    onPrimary: AppColors.roseOnPrimary,
    secondary: Color(0xFF3F3F46),
    onSecondary: AppColors.darkForeground,
    error: AppColors.roseDark,
    onError: AppColors.roseOnPrimary,
    surface: AppColors.darkBackground,
    onSurface: AppColors.darkForeground,
    surfaceContainerLowest: AppColors.darkBackground,
    surfaceContainerLow: Color(0xFF111111),
    surfaceContainer: AppColors.darkCard,
    surfaceContainerHigh: Color(0xFF222222),
    surfaceContainerHighest: AppColors.darkPopover,
    onSurfaceVariant: AppColors.darkMutedForeground,
    outline: AppColors.darkBorder,
    outlineVariant: AppColors.darkBorder,
  );

  static ThemeData _build(ColorScheme scheme, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final muted = isDark
        ? AppColors.darkMutedForeground
        : AppColors.lightMutedForeground;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    // Unified "glass" style for text fields — same translucent tint and
    // hairline as the surfaces (drawer, sheets, tiles) instead of an opaque
    // gray fill. Source of truth for ALL Material inputs in the app.
    final fieldFill = scheme.onSurface.withValues(alpha: 0.05);
    final fieldBorder = scheme.onSurface.withValues(alpha: 0.08);

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      // Default font for the whole app, so even ad-hoc TextStyles inherit it.
      fontFamily: _fontFamily,
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      splashFactory: InkRipple.splashFactory,
    );

    return base.copyWith(
      textTheme: _textTheme(base.textTheme, scheme.onSurface, muted),

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface.withValues(alpha: 0.85),
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),

      cardTheme: CardThemeData(
        color: scheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
          side: BorderSide(color: border),
        ),
      ),

      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(color: border),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xxl),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: fieldFill,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(color: scheme.onSurface.withValues(alpha: 0.3)),
        labelStyle: TextStyle(color: muted),
        prefixIconColor: scheme.onSurface.withValues(alpha: 0.4),
        suffixIconColor: scheme.onSurface.withValues(alpha: 0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: fieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: fieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(
            color: scheme.primary.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(
            color: scheme.onSurface.withValues(alpha: 0.04),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: scheme.error.withValues(alpha: 0.5)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.control),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primary.withValues(alpha: 0.10),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
            color: selected ? scheme.primary : muted.withValues(alpha: 0.6),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 22,
            color: selected ? scheme.primary : muted,
          );
        }),
        height: 64,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: scheme.surfaceContainerHighest,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xxl),
          ),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xxl),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        contentTextStyle: TextStyle(color: scheme.onSurface),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
    );
  }

  static TextTheme _textTheme(TextTheme base, Color fg, Color muted) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: fg,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: fg,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      displaySmall: base.displaySmall?.copyWith(
        color: fg,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: fg,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: fg,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: fg,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: fg,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: fg,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: fg,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: fg),
      bodyMedium: base.bodyMedium?.copyWith(color: fg),
      bodySmall: base.bodySmall?.copyWith(color: muted),
      labelLarge: base.labelLarge?.copyWith(
        color: fg,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: muted,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: muted,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Project design tokens — Dart equivalents of the shadcn/tailwind CSS
/// variables used by the PWA (`repster-pwa/app/globals.css`).
///
/// The original oklch values are approximated in sRGB. The PWA is the source
/// of truth: when a color changes there, update it here.
class AppColors {
  const AppColors._();

  // ── Brand ─────────────────────────────────────────────────────────────────
  /// Rose-700 — light theme primary (`oklch(0.514 0.222 16.935)`).
  static const Color roseLight = Color(0xFFBE123C);

  /// Rose-800 — dark theme primary (`oklch(0.455 0.188 13.697)`).
  static const Color roseDark = Color(0xFF9F1239);

  /// Rose-50 — text on primary (`oklch(0.969 0.015 12.422)`).
  static const Color roseOnPrimary = Color(0xFFFFF1F2);

  // ── Dark scheme (app default) ─────────────────────────────────────────────
  /// `oklch(0.065 0 0)` — near-black. This oklch renders as ≈ `#010101` in the
  /// browser (the PWA's real page background); the manifest `themeColor` uses a
  /// lighter `#0a0a0a` only for the OS status bar. We match the *content*
  /// background here so the app is as dark as the PWA.
  static const Color darkBackground = Color(0xFF010101);

  /// `oklch(0.135 0 0)` — card background.
  /// PWA autofill CSS uses rgb(25,25,25), so we align on it.
  static const Color darkCard = Color(0xFF191919);

  /// `oklch(0.205 0 0)` — popovers, sheets.
  static const Color darkPopover = Color(0xFF2A2A2A);

  /// `oklch(0.269 0 0)` — muted / accent surfaces.
  static const Color darkMuted = Color(0xFF404040);

  /// `oklch(0.985 0 0)` — primary text.
  static const Color darkForeground = Color(0xFFFAFAFA);

  /// `oklch(0.708 0 0)` — secondary text.
  static const Color darkMutedForeground = Color(0xFFA3A3A3);

  /// `oklch(0.27 0 0 / 50%)` — semi-transparent borders.
  static const Color darkBorder = Color(0x80404040);

  /// `oklch(0.32 0 0 / 50%)` — semi-transparent input background.
  static const Color darkInput = Color(0x80525252);

  /// `oklch(0.556 0 0)` — focus ring.
  static const Color darkRing = Color(0xFF737373);

  // ── Light scheme ──────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightForeground = Color(0xFF252525);
  static const Color lightMuted = Color(0xFFF5F5F5);
  static const Color lightMutedForeground = Color(0xFF737373);
  static const Color lightBorder = Color(0xFFEBEBEB);
  static const Color lightInput = Color(0xFFEBEBEB);
  static const Color lightRing = Color(0xFFB5B5B5);

  // ── Semantic accents (aligned with the PWA) ───────────────────────────────
  /// `emerald-400` — volume / tonnage (the dashboard's "green" figures).
  static const Color accentEmerald = Color(0xFF34D399);

  /// `orange-400` — streak / run of weeks.
  static const Color accentOrange = Color(0xFFFB923C);

  /// `amber-400` — records / personal best ("gold" medal).
  static const Color accentAmber = Color(0xFFFBBF24);

  /// `blue-400` — estimated 1RM / duration.
  static const Color accentBlue = Color(0xFF60A5FA);

  /// `rose-400` — negative change / regression (downward deltas).
  static const Color accentRose = Color(0xFFFB7185);

  /// `violet-400` — "Other" category in the contact form.
  static const Color accentViolet = Color(0xFFA78BFA);

  /// `rose-500` — the brand as *light*: glows, live dots, heat-map cells,
  /// button halos. The primary (rose-800) is right for a filled button, but
  /// spread thin over black it reads as mud rather than light.
  static const Color roseGlow = Color(0xFFF43F5E);
}

/// The three text tones of the dark UI. Every secondary text on a page should
/// be one of these, not an ad-hoc alpha: with one tone per role the pages read
/// as one voice instead of eight shades of grey.
extension AppTones on ColorScheme {
  /// Titles, values, names.
  Color get textPrimary => onSurface.withValues(alpha: 0.95);

  /// Supporting copy, meta lines, labels that carry meaning.
  Color get textSecondary => onSurface.withValues(alpha: 0.55);

  /// Hints, units, eyebrows, decorative glyphs.
  Color get textTertiary => onSurface.withValues(alpha: 0.35);

  /// The colour that *lights* a surface (glows, halos). See
  /// [AppColors.roseGlow].
  Color get glow =>
      brightness == Brightness.dark ? AppColors.roseGlow : primary;
}

/// Spacing scale (Tailwind's 4px baseline as used by the PWA).
/// Prefer these over inline magic values.
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  /// Standard horizontal screen margin (PWA `px-4`).
  static const double screenH = 16;
}

/// Standard radii — the PWA uses `--radius: 0.625rem` (10px) as its base, then
/// multiplies: sm=0.6, md=0.8, lg=1.0, xl=1.4, 2xl=1.8. Components (Card,
/// Button, Input) use `rounded-2xl` ≈ 18px.
class AppRadius {
  const AppRadius._();

  // ── Raw scale (not for direct use: prefer the roles below) ────────────────
  static const double sm = 6;
  static const double md = 8;
  static const double lg = 10;
  static const double xl = 14;
  static const double xxl = 18;

  // ── Radii by ROLE — PREFER THESE ──────────────────────────────────────────
  // Rule: the radius follows the element's SIZE, in steps. Two elements of the
  // same role/size MUST share the same radius.
  //
  //   pill (999)     → tags, badges, dots, progress bars, toggles
  //   chip (8)       → micro-squares & buttons ≤ 30 px (icon pills, numeric
  //                    badges, markers)
  //   controlSm (10) → small square controls / icon-buttons 32–40 px, tabs,
  //                    segmented options
  //   control (14)   → buttons, text fields, steppers, pickers (41–52 px)
  //   card (16)      → content cards, list rows, toasts
  //   sheet (24)     → bottom sheets, "hero" cards, modals, side drawers

  /// Micro-squares & buttons ≤ 30 px (icon pills, numeric badges).
  static const double chip = md;

  /// Small square controls / icon-buttons 32–40 px, tabs, segments.
  static const double controlSm = lg;

  /// Buttons, inputs, fields, steppers, pickers (41–52 px tall).
  static const double control = xl;

  /// Content cards, list rows, toasts (`rounded-2xl` ≈ 16).
  static const double card = 16;

  /// Bottom sheets, "hero" cards, modals, drawers (`rounded-3xl` ≈ 24).
  static const double sheet = 24;

  /// Legacy alias for [sheet].
  static const double cardLg = sheet;

  /// Fully rounded pills / badges / dots.
  static const double pill = 999;
}

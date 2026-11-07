import 'package:flutter/material.dart';

/// Canonical typography scale — the single source of truth for text sizes and
/// weights, mirroring the PWA (Tailwind + Manrope).
///
/// ## Rules (match the PWA)
///
/// **Sizes** live on a fixed grid — never invent in-between values (no 12.5,
/// 17, …). Allowed: 9, 10, 11, 12, 13, 14, 15, 16, 18, 20, 22, 24, 26, 30, 36.
///
/// **Weights** — the PWA leans *semibold*, not bold. Use:
/// - `w500` (medium) — body / secondary text
/// - `w600` (semibold) — the default emphasis: list titles, labels, buttons
/// - `w700` (bold) — headings and page/section titles
/// - `w800` (extrabold) — big display numbers only (greeting, stat values,
///   timers). Manrope tops out at 800, so never use `w900` (it forces a
///   heavier *synthetic* bold that doesn't match the PWA).
///
/// Styles are colour-agnostic: apply colour via `.copyWith(color: …)` or let
/// them inherit the ambient [DefaultTextStyle]. Uppercase "eyebrow" labels
/// ([sectionLabel]/[microLabel]) expect the text itself to be uppercased.
abstract final class AppText {
  const AppText._();

  // ── Display / numbers (w800) ───────────────────────────────────────────────
  /// Greeting name, hero numbers. PWA `text-[30px] font-black`.
  static const display = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    height: 1,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  /// Hero card title (the next session's name): the biggest text on the
  /// home page after the greeting.
  static const heroTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.6,
    height: 1.1,
  );

  /// Stat tile / KPI value. PWA `text-[22px] font-black`. Tabular figures so
  /// a row of values lines up and a ticking number does not jitter.
  static const statValue = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    height: 1,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  // ── Titles (w700) ──────────────────────────────────────────────────────
  /// Main screen title. PWA `text-[26px] font-bold`.
  static const pageTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  /// Large section / modal title. PWA `text-2xl font-bold`.
  static const titleLg = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
  );

  /// Standard title (app bars, sheets). PWA `text-xl font-bold`.
  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );

  /// Emphasised card title. PWA `text-[15px] font-bold`.
  static const cardTitle = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);

  // ── Content (w500 / w600) ──────────────────────────────────────────
  /// List-item / card heading. PWA `text-sm font-semibold`.
  static const subtitle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);

  /// Body text. PWA `text-sm`.
  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

  /// Emphasised body. PWA `text-sm font-semibold`.
  static const bodyStrong = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  /// Secondary / meta text. PWA `text-xs`.
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);

  // ── Eyebrow labels (uppercase) ─────────────────────────────────────────
  /// Section header eyebrow. PWA `text-[11px] uppercase tracking-[0.18em]
  /// font-semibold`.
  static const sectionLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.8,
  );

  /// Tiny metric label. PWA `text-[10px] uppercase tracking-wider font-bold`.
  static const microLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );
}

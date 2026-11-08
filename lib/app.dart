import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:repster/core/i18n/locale_sync.dart';
import 'package:repster/core/root_scaffold_messenger.dart';
import 'package:repster/core/router/app_router.dart';
import 'package:repster/core/theme/app_scroll_behavior.dart';
import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/core/web/safe_area.dart';
import 'package:repster/i18n/translations.g.dart';

class RepsterApp extends ConsumerWidget {
  const RepsterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    // Applies the persisted language (user_metadata) as soon as the session is
    // restored, and on every user change.
    ref.watch(localeSyncProvider);
    // Subscribes to `TranslationProvider`: any language change rebuilds the
    // `MaterialApp` and propagates the new locale to Flutter (dates, localized
    // Material/Cupertino widgets).
    final translationProvider = TranslationProvider.of(context);

    return MaterialApp.router(
      title: 'Repster',
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark, // PWA forces dark via <html class="dark">
      routerConfig: router,
      scrollBehavior: const AppScrollBehavior(),
      locale: translationProvider.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        // On the web the engine reports no safe area, so the page measures
        // it and the app takes the larger of the two on each side.
        final measured = measuredSafeArea();
        final padding = _max(mq.padding, measured);
        final viewPadding = _max(mq.viewPadding, measured);
        return MediaQuery(
          data: mq.copyWith(
            padding: padding,
            viewPadding: viewPadding,
            textScaler: mq.textScaler.clamp(maxScaleFactor: 1.3),
          ),
          child: child!,
        );
      },
    );
  }
}

EdgeInsets _max(EdgeInsets a, EdgeInsets b) => EdgeInsets.fromLTRB(
  math.max(a.left, b.left),
  math.max(a.top, b.top),
  math.max(a.right, b.right),
  math.max(a.bottom, b.bottom),
);

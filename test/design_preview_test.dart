// Design preview: renders the main screens with fake data and the real fonts,
// and writes one PNG per screen. Skipped unless an output folder is given:
//
//   flutter test test/design_preview_test.dart --dart-define=PREVIEW_OUT=/tmp/shots
//
// A quick way to look at a page without a device or a login.
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/auth/application/auth_controller.dart';
import 'package:repster/features/auth/domain/auth_user.dart';
import 'package:repster/features/auth/domain/auth_user_goal.dart';
import 'package:repster/features/auth/presentation/login_screen.dart';
import 'package:repster/features/dashboard/application/dashboard_controller.dart';
import 'package:repster/features/dashboard/domain/consistency.dart';
import 'package:repster/features/dashboard/domain/dashboard_data.dart';
import 'package:repster/features/dashboard/domain/in_progress_session_info.dart';
import 'package:repster/features/dashboard/domain/workout_session_summary.dart';
import 'package:repster/features/dashboard/presentation/dashboard_screen.dart';
import 'package:repster/features/history/application/history_controller.dart';
import 'package:repster/features/history/presentation/history_screen.dart';
import 'package:repster/features/profile/presentation/profile_screen.dart';
import 'package:repster/features/session/domain/workout_exercise.dart';
import 'package:repster/features/session/domain/workout_session.dart';
import 'package:repster/features/session/domain/workout_set.dart';
import 'package:repster/features/settings/presentation/settings_screen.dart';
import 'package:repster/features/stats/application/stats_controller.dart';
import 'package:repster/features/stats/presentation/stats_screen.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/muscle_group.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:repster/features/templates/presentation/templates_screen.dart';
import 'package:repster/i18n/translations.g.dart';

const _out = String.fromEnvironment('PREVIEW_OUT');

final _now = DateTime(2026, 11, 7, 18, 30);

final _user = AuthUser(
  id: 'u1',
  email: 'corentin@example.com',
  joinedAt: DateTime(2026, 2, 3),
  fullName: 'Corentin Deleuse',
  goal: AuthUserGoal.values.first,
);

TemplateSlot _slot(int i, String name, {int sets = 4, int reps = 8}) =>
    TemplateSlot(
      slotId: 's$i',
      order: i,
      supersetWithNext: false,
      variants: [
        TemplateExercise(
          id: 'e$i',
          name: name,
          sets: sets,
          reps: reps,
          tempo: '3-1-2-0',
          restTime: 120,
          notes: '',
          order: i,
        ),
      ],
    );

Template _tpl(
  String id,
  String name,
  List<MuscleGroup> tags,
  List<String> ex,
) => Template(
  id: id,
  name: name,
  description: '',
  tags: tags,
  slots: [for (var i = 0; i < ex.length; i++) _slot(i, ex[i])],
  isActive: true,
  createdAt: DateTime(2026, 3),
  updatedAt: DateTime(2026, 10),
);

final _templates = [
  _tpl(
    't1',
    'Push',
    [MuscleGroup.chest, MuscleGroup.shoulders, MuscleGroup.triceps],
    [
      'Développé couché',
      'Développé incliné haltères',
      'Dips',
      'Élévations latérales',
      'Extension triceps poulie',
    ],
  ),
  _tpl(
    't2',
    'Pull',
    [MuscleGroup.back, MuscleGroup.biceps],
    [
      'Tractions',
      'Rowing barre',
      'Tirage horizontal',
      'Curl haltères',
      'Face pull',
    ],
  ),
  _tpl(
    't3',
    'Legs',
    [MuscleGroup.quads, MuscleGroup.hamstrings, MuscleGroup.glutes],
    ['Squat', 'Soulevé de terre roumain', 'Presse', 'Leg curl', 'Mollets'],
  ),
  _tpl(
    't4',
    'Upper',
    [MuscleGroup.chest, MuscleGroup.back],
    ['Développé militaire', 'Tractions lestées', 'Dips', 'Rowing'],
  ),
  _tpl(
    't5',
    'Core & mobilité',
    [MuscleGroup.abs],
    ['Planche', 'Relevés de jambes', 'Pallof press'],
  ),
];

WorkoutSessionSummary _sum(
  int i,
  String name,
  List<MuscleGroup> tags,
  int daysAgo,
  double tonnage,
  int minutes,
) => WorkoutSessionSummary(
  id: 'ws$i',
  templateName: name,
  templateId: 't${(i % 3) + 1}',
  startedAt: _now.subtract(Duration(days: daysAgo, hours: 2)),
  durationSeconds: minutes * 60,
  totalTonnageKg: tonnage,
  totalSets: 18,
  tags: tags,
);

final _sessions = [
  _sum(1, 'Push', [MuscleGroup.chest, MuscleGroup.triceps], 0, 6420, 58),
  _sum(2, 'Legs', [MuscleGroup.quads, MuscleGroup.glutes], 2, 9850, 71),
  _sum(3, 'Pull', [MuscleGroup.back, MuscleGroup.biceps], 4, 5210, 55),
  _sum(4, 'Push', [MuscleGroup.chest], 7, 6100, 60),
  _sum(5, 'Upper', [MuscleGroup.chest, MuscleGroup.back], 9, 7300, 64),
  _sum(6, 'Legs', [MuscleGroup.quads], 11, 9400, 69),
  _sum(7, 'Pull', [MuscleGroup.back], 14, 5000, 52),
  _sum(8, 'Push', [MuscleGroup.chest], 16, 5900, 57),
];

List<DateTime> _dates() {
  final out = <DateTime>[];
  for (var d = 0; d < 120; d += 1) {
    if (d % 7 == 0 || d % 7 == 2 || d % 7 == 4 || (d % 13 == 0)) {
      out.add(_now.subtract(Duration(days: d)));
    }
  }
  return out;
}

WorkoutSet _set(int n, double w, int reps) => WorkoutSet(
  id: 'set$n',
  setNumber: n,
  targetReps: reps,
  actualReps: reps,
  weight: w,
  completed: true,
);

WorkoutExercise _wex(String id, String name, double w, int reps) =>
    WorkoutExercise(
      id: id,
      name: name,
      notes: '',
      tempo: '3-1-2-0',
      restTime: 120,
      sets: [for (var i = 1; i <= 4; i++) _set(i, w, reps)],
    );

List<WorkoutSession> _fullSessions() {
  final out = <WorkoutSession>[];
  for (var i = 0; i < 24; i++) {
    final kind = i % 3;
    final w = 60.0 + (24 - i) * 1.25;
    out.add(
      WorkoutSession(
        id: 'full$i',
        templateId: 't${kind + 1}',
        templateName: ['Push', 'Pull', 'Legs'][kind],
        startedAt: _now.subtract(Duration(days: i * 3 + 1)),
        duration: 3600,
        tags: [
          [MuscleGroup.chest, MuscleGroup.triceps],
          [MuscleGroup.back, MuscleGroup.biceps],
          [MuscleGroup.quads, MuscleGroup.glutes],
        ][kind],
        notes: '',
        exercises: [
          _wex(
            'a$i',
            ['Développé couché', 'Tractions', 'Squat'][kind],
            w + 20,
            6,
          ),
          _wex('b$i', ['Dips', 'Rowing barre', 'Presse'][kind], w, 10),
          _wex(
            'c$i',
            ['Élévations latérales', 'Curl', 'Leg curl'][kind],
            w / 4,
            12,
          ),
        ],
      ),
    );
  }
  return out;
}

class _Auth extends AuthController {
  @override
  Future<AuthUser?> build() async => _user;
}

class _Templates extends TemplatesController {
  @override
  Future<List<Template>> build() async => _templates;
}

class _History extends HistoryController {
  @override
  Future<List<WorkoutSessionSummary>> build() async => _sessions;
}

class _Dash extends DashboardController {
  _Dash({this.inProgress = false});
  final bool inProgress;
  @override
  Future<DashboardData> build() async => DashboardData(
    user: _user,
    activeTemplates: _templates,
    recentSessions: _sessions,
    consistency: Consistency.fromDates(_dates(), now: _now),
    suggestedTemplate: _templates[1],
    inProgress: inProgress
        ? InProgressSessionInfo(
            sessionId: 'ip',
            templateName: 'Pull',
            startedAt: _now.subtract(const Duration(minutes: 42)),
          )
        : null,
  );
}

Future<void> _loadFonts() async {
  final manifest =
      json.decode(await rootBundle.loadString('FontManifest.json'))
          as List<dynamic>;
  for (final entry in manifest) {
    final m = entry as Map<String, dynamic>;
    final family = (m['family'] as String)
        .replaceFirst('packages/', '')
        .split('/')
        .last;
    final loader = FontLoader(m['family'] as String);
    final alias = FontLoader(family);
    for (final f in m['fonts'] as List<dynamic>) {
      final asset = (f as Map<String, dynamic>)['asset'] as String;
      loader.addFont(rootBundle.load(asset));
      alias.addFont(rootBundle.load(asset));
    }
    await loader.load();
    await alias.load();
  }
  final emoji = File('/usr/share/fonts/truetype/noto/NotoColorEmoji.ttf');
  if (emoji.existsSync()) {
    final bytes = await emoji.readAsBytes();
    final l = FontLoader('NotoEmoji')
      ..addFont(Future.value(ByteData.view(bytes.buffer)));
    await l.load();
  }
}

ThemeData _theme() {
  final base = AppTheme.dark();
  return base.copyWith(
    textTheme: base.textTheme.apply(fontFamilyFallback: const ['NotoEmoji']),
  );
}

Future<void> _shoot(
  WidgetTester tester,
  String name,
  Widget screen,
  List<Override> overrides, {
  double height = 844,
  Future<void> Function(WidgetTester)? act,
}) async {
  tester.view.physicalSize = Size(390 * 3, height * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final key = GlobalKey();
  await tester.runAsync(() async {
    await _loadFonts();
  });
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: TranslationProvider(
        child: RepaintBoundary(
          key: key,
          child: MaterialApp(
            theme: _theme(),
            darkTheme: _theme(),
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            home: DefaultTextStyle.merge(
              style: const TextStyle(fontFamilyFallback: ['NotoEmoji']),
              child: screen,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1500));
  await tester.pump(const Duration(milliseconds: 1500));
  if (act != null) {
    await act(tester);
    await tester.pump(const Duration(milliseconds: 1500));
  }
  await tester.runAsync(() async {
    final boundary =
        key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File('$_out/$name.png').writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

void main() {
  if (_out.isEmpty) return;
  setUpAll(() async {
    LocaleSettings.setLocaleSync(AppLocale.fr);
    await initializeDateFormatting('fr');
    Intl.defaultLocale = 'fr';
  });

  final common = <Override>[
    authControllerProvider.overrideWith(_Auth.new),
    templatesControllerProvider.overrideWith(_Templates.new),
    historyControllerProvider.overrideWith(_History.new),
    statsSessionsProvider.overrideWith((ref) async => _fullSessions()),
  ];

  testWidgets('dashboard', (t) async {
    await _shoot(t, 'dashboard', const DashboardScreen(), [
      ...common,
      dashboardControllerProvider.overrideWith(_Dash.new),
    ], height: 1400);
  });
  testWidgets('dashboard in progress', (t) async {
    await _shoot(t, 'dashboard_inprogress', const DashboardScreen(), [
      ...common,
      dashboardControllerProvider.overrideWith(() => _Dash(inProgress: true)),
    ], height: 1000);
  });
  testWidgets('templates', (t) async {
    await _shoot(t, 'templates', const TemplatesScreen(), common, height: 1100);
  });
  testWidgets('templates manage', (tester) async {
    await _shoot(
      tester,
      'templates_manage',
      const TemplatesScreen(),
      common,
      height: 1100,
      act: (w) async {
        await w.tap(find.text(t.templates.list.manage));
      },
    );
  });
  testWidgets('history', (t) async {
    await _shoot(t, 'history', const HistoryScreen(), common, height: 1300);
  });
  testWidgets('stats', (t) async {
    await _shoot(t, 'stats', const StatsScreen(), common, height: 1800);
  });
  testWidgets('settings', (t) async {
    await _shoot(t, 'settings', const SettingsScreen(), common, height: 1200);
  });
  testWidgets('profile', (t) async {
    await _shoot(t, 'profile', const ProfileScreen(), common, height: 1100);
  });
  testWidgets('login', (t) async {
    await _shoot(t, 'login', const LoginScreen(), common);
  });
}

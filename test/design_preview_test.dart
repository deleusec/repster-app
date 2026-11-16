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

import 'package:repster/core/emoji/fluent_emoji.dart';
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
import 'package:repster/features/templates/application/programs_controller.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/program.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/domain/template_exercise.dart';
import 'package:repster/features/templates/domain/template_slot.dart';
import 'package:repster/features/templates/presentation/program_screen.dart';
import 'package:repster/features/templates/presentation/template_detail_screen.dart';
import 'package:repster/features/templates/presentation/template_edit_screen.dart';
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

TemplateSlot _slot(
  int i,
  String name, {
  int sets = 4,
  int reps = 8,
  bool superset = false,
  String? variant,
  String notes = '',
  int? holdSeconds,
}) => TemplateSlot(
  slotId: 's$i',
  order: i,
  supersetWithNext: superset,
  variants: [
    TemplateExercise(
      id: 'e$i',
      name: name,
      sets: sets,
      reps: reps,
      tempo: '3-1-2-0',
      restTime: 120,
      notes: notes,
      order: i,
      isTimeBased: holdSeconds != null,
      durationSeconds: holdSeconds,
    ),
    if (variant != null)
      TemplateExercise(
        id: 'e${i}b',
        name: variant,
        sets: sets,
        reps: reps,
        tempo: '3-1-2-0',
        restTime: 120,
        notes: '',
        order: i,
      ),
  ],
);

const _emojiByName = {
  'Push': FluentEmojis.fire,
  'Pull': FluentEmojis.crescentMoon,
  'Legs': FluentEmojis.mountain,
  'Upper': FluentEmojis.shield,
};

Template _tpl(String id, String name, List<String> ex) => Template(
  id: id,
  name: name,
  description: '',
  emoji: _emojiByName[name] ?? FluentEmojis.brick,
  slots: [for (var i = 0; i < ex.length; i++) _slot(i, ex[i])],
  isActive: true,
  createdAt: DateTime(2026, 3),
  updatedAt: DateTime(2026, 10),
);

final _templates = [
  Template(
    id: 't1',
    name: 'Push',
    description:
        'Push A orienté force : top single puis back-off au développé couché, '
        'haut des pectoraux, deltoïdes latéraux et triceps.',
    emoji: FluentEmojis.fire,
    slots: [
      _slot(0, 'Développé couché', variant: 'Développé couché haltères'),
      _slot(1, 'Développé incliné haltères', sets: 3, reps: 10, superset: true),
      _slot(2, 'Dips', sets: 3, reps: 12),
      _slot(
        3,
        'Élévations latérales',
        reps: 15,
        notes: 'Coudes hauts, pas de balancement.',
      ),
      _slot(4, 'Extension triceps poulie', sets: 3, reps: 12),
      _slot(5, 'Gainage', sets: 3, holdSeconds: 45),
    ],
    isActive: true,
    createdAt: DateTime(2026, 3),
    updatedAt: DateTime(2026, 10),
  ),
  _tpl('t2', 'Pull', [
    'Tractions',
    'Rowing barre',
    'Tirage horizontal',
    'Curl haltères',
    'Face pull',
  ]),
  _tpl('t3', 'Legs', [
    'Squat',
    'Soulevé de terre roumain',
    'Presse',
    'Leg curl',
    'Mollets',
  ]),
  _tpl('t4', 'Upper', [
    'Développé militaire',
    'Tractions lestées',
    'Dips',
    'Rowing',
  ]),
  _tpl('t5', 'Core & mobilité', [
    'Planche',
    'Relevés de jambes',
    'Pallof press',
  ]),
];

WorkoutSessionSummary _sum(
  int i,
  String name,
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
  emoji: _emojiByName[name] ?? FluentEmojis.brick,
);

final _sessions = [
  _sum(1, 'Push', 0, 6420, 58),
  _sum(2, 'Legs', 2, 9850, 71),
  _sum(3, 'Pull', 4, 5210, 55),
  _sum(4, 'Push', 7, 6100, 60),
  _sum(5, 'Upper', 9, 7300, 64),
  _sum(6, 'Legs', 11, 9400, 69),
  _sum(7, 'Pull', 14, 5000, 52),
  _sum(8, 'Push', 16, 5900, 57),
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

const _programs = [
  Program(id: 'p1', name: 'Push Pull Legs', isActive: true),
  Program(id: 'p2', name: 'Vacances', isActive: false),
  Program(id: 'p3', name: 'Prépa trail', isActive: false),
];

Template _extra(String id, String name, FluentEmoji emoji, {String? program}) =>
    _tpl(id, name, [
      'Planche',
      'Fentes',
      'Pompes',
    ]).copyWith(emoji: emoji, programId: program, isActive: false);

/// The same sessions, filed: three in the active program, the rest spread
/// over two idle programs and the loose tiles.
final _filed = [
  for (final t in _templates.take(3)) t.copyWith(programId: 'p1'),
  _templates[3].copyWith(programId: 'p2', isActive: false),
  _extra('t6', 'Full body', FluentEmojis.rocket, program: 'p2'),
  _extra('t7', 'Côtes', FluentEmojis.personRunning, program: 'p3'),
  _extra('t8', 'Sortie longue', FluentEmojis.runningShoe, program: 'p3'),
  _extra('t9', 'Vélo', FluentEmojis.bicycle, program: 'p3'),
  _extra('t10', 'Renfo', FluentEmojis.highVoltage, program: 'p3'),
  _templates[4],
  _extra('t11', 'Étirements', FluentEmojis.lotus),
];

class _Templates extends TemplatesController {
  @override
  Future<List<Template>> build() async => _filed;
}

class _Programs extends ProgramsController {
  @override
  Future<List<Program>> build() async => _programs;
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
  double width = 390,
  double height = 844,
  Future<void> Function(WidgetTester)? act,
}) async {
  tester.view.physicalSize = Size(width * 3, height * 3);
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
  // Asset images (the Fluent emoji) decode on real I/O, which only runs
  // inside `runAsync`; give them a moment, then paint the decoded frames.
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 600)),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
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
    programsControllerProvider.overrideWith(_Programs.new),
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
    await _shoot(t, 'templates', const TemplatesScreen(), common, height: 900);
  });
  testWidgets('templates on a wide window', (t) async {
    await _shoot(
      t,
      'templates_desktop',
      const TemplatesScreen(),
      common,
      width: 1280,
      height: 800,
    );
  });
  testWidgets('program', (t) async {
    await _shoot(
      t,
      'program',
      const ProgramScreen(id: 'p1'),
      common,
      height: 900,
    );
  });
  testWidgets('program idle', (t) async {
    await _shoot(
      t,
      'program_idle',
      const ProgramScreen(id: 'p3'),
      common,
      height: 900,
    );
  });
  testWidgets('template detail', (t) async {
    await _shoot(
      t,
      'template_detail',
      const TemplateDetailScreen(id: 't1'),
      common,
      height: 1300,
    );
  });
  testWidgets('template edit', (t) async {
    await _shoot(
      t,
      'template_edit',
      const TemplateEditScreen(),
      common,
      height: 1100,
    );
  });
  testWidgets('emoji picker', (tester) async {
    await _shoot(
      tester,
      'emoji_picker',
      const TemplateEditScreen(),
      common,
      height: 1100,
      act: (w) async {
        await w.tap(find.text(t.templates.emojiPicker.change));
        await w.pump(const Duration(milliseconds: 600));
        await w.enterText(find.byType(TextField).last, 'fe');
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

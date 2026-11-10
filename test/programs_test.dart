import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repster/core/emoji/fluent_emoji.dart';
import 'package:repster/core/theme/app_theme.dart';
import 'package:repster/features/templates/application/programs_controller.dart';
import 'package:repster/features/templates/application/templates_controller.dart';
import 'package:repster/features/templates/domain/program.dart';
import 'package:repster/features/templates/domain/template.dart';
import 'package:repster/features/templates/presentation/templates_screen.dart';
import 'package:repster/features/templates/presentation/widgets/program_folder_card.dart';
import 'package:repster/features/templates/presentation/widgets/session_tile.dart';
import 'package:repster/i18n/translations.g.dart';

Template _tpl(String id, {String? program, bool active = true}) => Template(
  id: id,
  name: 'Session $id',
  description: '',
  emoji: FluentEmojis.fire,
  slots: const [],
  isActive: active,
  programId: program,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

final _seed = [
  _tpl('a', program: 'p1'),
  _tpl('b', program: 'p2', active: false),
  _tpl('c'),
  _tpl('d', program: 'p1', active: false),
  _tpl('e', active: false),
];

class _Templates extends TemplatesController {
  @override
  Future<List<Template>> build() async => _seed;
}

class _Programs extends ProgramsController {
  @override
  Future<List<Program>> build() async => const [
    Program(id: 'p1', name: 'PPL', isActive: true),
    Program(id: 'p2', name: 'Holidays', isActive: false),
  ];
}

Future<ProviderContainer> _container() async {
  final container = ProviderContainer(
    overrides: [
      templatesControllerProvider.overrideWith(_Templates.new),
      programsControllerProvider.overrideWith(_Programs.new),
    ],
  );
  addTearDown(container.dispose);
  await container.read(templatesControllerProvider.future);
  return container;
}

Map<String, bool> _active(ProviderContainer c) => {
  for (final t in c.read(templatesControllerProvider).requireValue)
    t.id: t.isActive,
};

void main() {
  group('applyProgramActivation', () {
    test('switching a program on switches the other programs off', () async {
      final c = await _container();
      c
          .read(templatesControllerProvider.notifier)
          .applyProgramActivation('p2', isActive: true);

      expect(_active(c), {
        'a': false,
        'b': true,
        // Sessions outside any program keep their own switch.
        'c': true,
        'd': false,
        'e': false,
      });
    });

    test('switching a program off only touches its own sessions', () async {
      final c = await _container();
      c
          .read(templatesControllerProvider.notifier)
          .applyProgramActivation('p1', isActive: false);

      expect(_active(c), {
        'a': false,
        'b': false,
        'c': true,
        'd': false,
        'e': false,
      });
    });
  });

  test('a deleted program releases its sessions', () async {
    final c = await _container();
    c.read(templatesControllerProvider.notifier).releaseProgram('p1');

    final list = c.read(templatesControllerProvider).requireValue;
    expect(list, hasLength(_seed.length));
    expect(list.where((t) => t.programId == 'p1'), isEmpty);
    expect(list.firstWhere((t) => t.id == 'b').programId, 'p2');
  });

  testWidgets('the grid shows programs as folders, loose sessions as tiles', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(700, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          templatesControllerProvider.overrideWith(_Templates.new),
          programsControllerProvider.overrideWith(_Programs.new),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          home: const TemplatesScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ProgramFolderCard), findsNWidgets(2));
    // 'c' and 'e'; sessions filed in a program stay inside their folder.
    expect(find.byType(SessionTile), findsNWidgets(2));
    expect(find.text('Session a'), findsNothing);
    // Only the active program carries the label.
    expect(find.text(t.templates.programs.active), findsOneWidget);
    expect(find.text(t.templates.programs.sessionInactive), findsOneWidget);
  });
}

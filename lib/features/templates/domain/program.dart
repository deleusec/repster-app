import 'package:freezed_annotation/freezed_annotation.dart';

part 'program.freezed.dart';

/// A program — a named folder of sessions. At most one is active at a time;
/// which sessions it holds is carried by `Template.programId`.
@freezed
class Program with _$Program {
  const factory Program({
    required String id,
    required String name,
    required bool isActive,
  }) = _Program;
}

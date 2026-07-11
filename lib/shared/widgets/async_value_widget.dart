import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/shared/widgets/app_error.dart';
import 'package:repster/shared/widgets/app_loading.dart';

/// Standardized `AsyncValue.when` wrapper. Use this in screens instead of
/// repeating loading/error scaffolding everywhere.
///
/// ```dart
/// final templates = ref.watch(templatesControllerProvider);
/// return AsyncValueWidget<List<Template>>(
///   value: templates,
///   onRetry: () => ref.invalidate(templatesControllerProvider),
///   data: (list) => TemplatesList(items: list),
/// );
/// ```
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    required this.value,
    required this.data,
    this.onRetry,
    this.loading,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => loading ?? const AppLoading(),
      error: (error, _) => AppError(error: error, onRetry: onRetry),
    );
  }
}

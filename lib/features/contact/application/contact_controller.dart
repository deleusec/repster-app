import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repster/features/contact/data/contact_repository.dart';

/// Contact form controller. Mediates repository access so the presentation
/// layer never depends on `data/` directly.
class ContactController extends Notifier<void> {
  @override
  void build() {}

  Future<void> submit({
    required String name,
    required String email,
    required String category,
    required String message,
  }) {
    return ref
        .read(contactRepositoryProvider)
        .submit(name: name, email: email, category: category, message: message);
  }
}

final contactControllerProvider = NotifierProvider<ContactController, void>(
  ContactController.new,
);

/// Builds the insert payload for `contact_requests`.
/// `user_id` is supplied by the caller (from the authenticated session).
class ContactRequestDto {
  const ContactRequestDto._();

  static Map<String, Object?> toInsert({
    required String userId,
    required String name,
    required String email,
    required String category,
    required String message,
  }) {
    return {
      'user_id': userId,
      'name': name.trim(),
      'email': email.trim(),
      'category': category,
      'message': message.trim(),
    };
  }
}

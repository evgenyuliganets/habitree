class User {
  const User({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
}

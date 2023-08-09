class User {
  final String? userId;
  final String? fullName;
  final String? phone;
  final String? role;
  final int? userAttempts;
  final String? avatar;
  final bool? confirm;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  User({
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.role,
    required this.userAttempts,
    required this.avatar,
    required this.confirm,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
}
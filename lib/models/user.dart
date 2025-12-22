class User {
  final String id;
  final String email;
  final String name;
  final String? avatarPath;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarPath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatarPath': avatarPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      avatarPath: map['avatarPath'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

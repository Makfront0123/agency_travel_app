import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String role;
  final String imageUser;
  final bool accountVerified;
  final String token;

  const User({
    required this.lastName,
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.imageUser,
    required this.accountVerified,
  });

  @override
  List<Object?> get props =>
      [id, name, lastName, email, role, imageUser, accountVerified, token];
}

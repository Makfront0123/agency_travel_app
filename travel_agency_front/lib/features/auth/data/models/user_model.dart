import 'package:travel_agency_front/features/auth/domain/entities/user.dart';

class UserModel extends User {
  final String? otp;
  final DateTime? otpExpires;
  final String? resetPasswordToken;
  final DateTime? resetPasswordExpires;

  const UserModel({
    required super.token,
    required super.role,
    required super.id,
    required super.lastName,
    required super.name,
    required super.email,
    required super.imageUser,
    required super.accountVerified,
    this.otp,
    this.otpExpires,
    this.resetPasswordToken,
    this.resetPasswordExpires,
  });

  factory UserModel.fromJson(Map<String, dynamic> json,
          {required String token}) =>
      UserModel(
        token: token,
        role: json['role'] ?? 'customer',
        id: json['userId'] ?? '', // antes _id
        name: json['name'] ?? '',
        lastName: json['lastName'] ?? '',
        email: json['email'] ?? '',
        imageUser: json['imageUser'] ?? '',
        accountVerified: json['verified'] ?? false,
        otp: json['otp'],
        otpExpires: json['otpExpires'] != null
            ? DateTime.tryParse(json['otpExpires'])
            : null,
        resetPasswordToken: json['resetPasswordToken'],
        resetPasswordExpires: json['resetPasswordExpires'] != null
            ? DateTime.tryParse(json['resetPasswordExpires'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'lastName': lastName,
        'email': email,
        'imageUser': imageUser,
        'accountVerified': accountVerified,
        'otp': otp,
        'role': role,
        'token': token,
        'otpExpires': otpExpires?.toIso8601String(),
        'resetPasswordToken': resetPasswordToken,
        'resetPasswordExpires': resetPasswordExpires?.toIso8601String(),
      };

  User toEntity() {
    return User(
      id: id,
      name: name,
      lastName: lastName,
      email: email,
      imageUser: imageUser,
      accountVerified: accountVerified,
      role: role,
      token: token,
    );
  }

  @override
  List<Object?> get props =>
      super.props +
      [
        otp,
        otpExpires,
        resetPasswordToken,
        token,
        resetPasswordExpires,
      ];
}

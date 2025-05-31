import 'package:travel_agency_front/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> loginWithToken(String token);
  Future<Map<String, dynamic>> verify(String email, String otp);
  Future<Map<String, dynamic>> forgotPassword(String email);
  Future<Map<String, dynamic>> verifyForgot(String email, String otp);
  Future<Map<String, dynamic>> resendOtp(String email);
  Future<Map<String, dynamic>> resendForgotPasswordOtp(String email);
  Future<Map<String, dynamic>> resetPassword(
      String email, String password, String newPassword);
  Future<void> logout();
  Future<User> getCurrentUser(String token);
  Future<User> register(String name, String lastName, String email,
      String password, String confirmPassword);
}

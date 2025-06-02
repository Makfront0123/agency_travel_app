import 'package:dio/dio.dart';
import 'package:travel_agency_front/features/auth/data/models/user_model.dart';

class AuthApiService {
  final Dio _dio;
  final String baseUrl;

  AuthApiService(this._dio, this.baseUrl);

  Future<UserModel> register(String name, String lastName, String email,
      String password, String confirmPassword) async {
    print('BASEURL $baseUrl');
    try {
      final response = await _dio.post('$baseUrl/register', data: {
        'name': name,
        'lastName': lastName,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword
      });

      final userData = response.data;

      final user = UserModel.fromJson(userData, token: '');

      return user;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/login', data: {
        'email': email,
        'password': password,
      });

      print('response.data ${response.data}');

      final data = response.data;
      final token = data['token'];

      final user = UserModel.fromJson(data, token: token);

      return user;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserModel> getCurrentUser(String token) async {
    try {
      final response = await _dio.get('$baseUrl/check-auth',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final data = response.data;

      return UserModel.fromJson(data['data'], token: token);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw SessionExpiredException('Session expired. Please login again.');
      }
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<dynamic> logout() async {
    try {
      final response = await _dio.post('$baseUrl/logout');

      return response.data;
    } catch (e) {
      return e;
    }
  }

  Future<Map<String, dynamic>> verify(String email, String otp) async {
    try {
      final response = await _dio
          .post('$baseUrl/verify', data: {'email': email, 'otp': otp});

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);
      return Future.error(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        '$baseUrl/forgot',
        data: {'email': email},
      );

      return {
        'message': response.data.toString(),
      };
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  Future<Map<String, dynamic>> verifyForgot(String email, String otp) async {
    try {
      final response = await _dio
          .post('$baseUrl/verifyForgot', data: {'email': email, 'otp': otp});

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      String email, String password, String newPassword) async {
    try {
      final response = await _dio.post('$baseUrl/reset-password', data: {
        'email': email,
        'password': password,
        'newPassword': newPassword
      });

      return {
        'message': response.data.toString(),
      };
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  String _extractErrorMessage(DioException e) {
    try {
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        final message = data['message'];
        if (message is String) return message;
      }
      if (data is String) return data;
      return e.message ?? 'Login failed';
    } catch (_) {
      return 'Login failed';
    }
  }

  Future<Map<String, dynamic>> resendOtp(String email) async {
    try {
      final response = await _dio.post('$baseUrl/resend-otp', data: {
        'email': email,
      });

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }

  Future<Map<String, dynamic>> resendForgotPasswordOtp(String email) async {
    try {
      final response = await _dio.post('$baseUrl/resend-forgot-otp', data: {
        'email': email,
      });

      return response.data;
    } on DioException catch (e) {
      final message = _extractErrorMessage(e);

      return Future.error(message);
    } catch (e) {
      return Future.error('Unexpected error');
    }
  }
}

class SessionExpiredException implements Exception {
  final String message;
  SessionExpiredException(this.message);

  @override
  String toString() => message;
}

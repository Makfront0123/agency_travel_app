import 'package:travel_agency_front/features/auth/domain/entities/user.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/login_auth.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';

class AppStarted {
  final StorageService storageService;
  final LoginUser loginUser;

  AppStarted({
    required this.storageService,
    required this.loginUser,
  });

  Future<User?> call() async {
    final token = await storageService.getToken();
    if (token != null) {
      try {
        final user = await loginUser.autoLoginWithToken(token);

        return user;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}

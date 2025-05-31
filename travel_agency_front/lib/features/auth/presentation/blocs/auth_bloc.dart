import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/forgot_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/login_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/logout_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/register_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/resend_otp_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/resend_otp_forgot.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/reset_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/verify_forgot.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/verify_otp_user.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUser _logoutUser;
  final LoginUser _loginUser;
  final RegisterUser _registerUser;
  final VerifyAccount _verifyOtp;
  final ForgotAuth _forgotPassword;
  final ResetAuth _resetPassword;
  final VerifyForgot _verifyForgot;
  final ResendOtp _resendOtp;
  final ResendOtpForgot _resendOtpForgot;
  final StorageService _storageService;

  AuthBloc({
    required StorageService storageService,
    required ResendOtp resendOtp,
    required ForgotAuth forgotPassword,
    required LoginUser loginUser,
    required LogoutUser logoutUser,
    required ResendOtpForgot resendOtpForgot,
    required VerifyForgot verifyForgot,
    required RegisterUser registerUser,
    required VerifyAccount verifyOtp,
    required ResetAuth resetPassword,
  })  : _logoutUser = logoutUser,
        _storageService = storageService,
        _loginUser = loginUser,
        _registerUser = registerUser,
        _verifyOtp = verifyOtp,
        _verifyForgot = verifyForgot,
        _resendOtp = resendOtp,
        _forgotPassword = forgotPassword,
        _resendOtpForgot = resendOtpForgot,
        _resetPassword = resetPassword,
        super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<RegisterEvent>(_onRegister);
    on<ResetAuthState>((_, emit) => emit(AuthInitial()));
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ForgotEvent>(_onForgot);
    on<ResetPasswordEvent>(_onResetPassword);
    on<VerifyForgotEvent>(_onVerifyForgot);
    on<ResendOtpEvent>(_onResendOtp);
    on<ResendOtpForgotEvent>(_onResendOtpForgot);
    on<AppStarted>(_onAppStarted);
    on<UpdateUserFromProfile>(_onUpdateUserFromProfile);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 7));

    final token = await _storageService.getToken();

    if (token == null) {
      emit(AuthUnauthenticated());
      return;
    }

    try {
      final user = await _loginUser.autoLoginWithToken(token);
      emit(Authenticated(user: user));
    } on SessionExpiredException catch (_) {
      add(const LogoutEvent()); // Maneja token expirado
    } catch (e) {
      await _storageService.clearToken(); // Otras excepciones
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _loginUser(event.email, event.password);

      await _storageService.saveToken(user.token);

      if (user.accountVerified) {
        emit(Authenticated(user: user));
      } else {
        emit(AuthVerificationSuccess());
      }
    } catch (e) {
      emit(AuthError("Failed to login: ${e.toString()}"));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await _registerUser(
        event.name,
        event.lastName,
        event.email,
        event.password,
        event.confirmPassword,
      );

      emit(AuthRegistrationSuccess(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      await _verifyOtp(event.email, event.otp);

      emit(const AuthOtpVerified('OTP Verified Successfully'));
    } catch (e) {
      String errorMessage;
      if (e is String) {
        errorMessage = e;
      } else if (e is Exception) {
        errorMessage = e.toString();
      } else {
        errorMessage = 'Unknown error';
      }
      emit(AuthError(errorMessage));
    }
  }

  Future<void> _onForgot(ForgotEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final res = await _forgotPassword(event.email);
      emit(AuthForgotSuccess(res['message']));
      emit(AuthForgotPasswordOtpSent(event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyForgot(
      VerifyForgotEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _verifyForgot(event.otp, event.email);

      emit(AuthOtpVerifiedForReset(
        email: event.email,
        token: '',
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResetPassword(
      ResetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response =
          await _resetPassword(event.email, event.password, event.newPassword);
      emit(AuthResetPasswordSuccess(response['message']));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResendOtp(
      ResendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _resendOtp(event.email);
      emit(AuthVerificationSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onResendOtpForgot(
      ResendOtpForgotEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _resendOtpForgot(event.email);

      emit(AuthForgotPasswordOtpSent(event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _logoutUser();
      await _storageService.clearToken();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onUpdateUserFromProfile(
      UpdateUserFromProfile event, Emitter<AuthState> emit) {
    final currentState = state;
    if (currentState is Authenticated) {
      emit(Authenticated(user: event.user));
    }
  }
}

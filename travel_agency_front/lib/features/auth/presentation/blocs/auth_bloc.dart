import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/domain/entities/user.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const Authenticated(
          user: User(
              name: 'John Doe',
              email: 'john@doe.com',
              password: '123456',
              token: '123456',
              accountVerified: true)));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}

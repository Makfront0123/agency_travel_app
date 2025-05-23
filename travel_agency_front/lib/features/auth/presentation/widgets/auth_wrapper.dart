import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/application/presentation/application_screen.dart';
import 'package:travel_agency_front/features/application/presentation/widgets/load_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return const LoadScreen(isLoading: true, child: SizedBox.shrink());
        }
        if (state is AuthLoading) {
          return const LoadScreen(isLoading: true, child: SizedBox.shrink());
        }
        if (state is Authenticated) {
          return const ApplicationScreen();
        }
        if (state is AuthUnauthenticated) {
          return const LoginScreen();
        }

        return Center(child: Text('Estado no manejado: $state'));
      },
    );
  }
}

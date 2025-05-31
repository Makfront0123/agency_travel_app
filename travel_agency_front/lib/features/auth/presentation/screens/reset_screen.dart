import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_formfield.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/text_form_wrapper.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  void _onReset() {
    final state = context.read<AuthBloc>().state;
    String? email;

    if (state is AuthOtpVerifiedForReset) {
      email = state.email;
    }

    context.read<AuthBloc>().add(ResetPasswordEvent(
          email: email ?? '',
          password: passwordController.text,
          newPassword: confirmPasswordController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordSuccess) {
          Navigator.pushReplacementNamed(context, '/login');
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 50),
              AuthFormfield(controller: passwordController, label: 'Password'),
              const SizedBox(height: 20),
              AuthFormfield(
                  controller: confirmPasswordController,
                  label: 'Confirm Password'),
              const SizedBox(height: 30),
              AuthButton(
                onTap: _onReset,
                text: 'Continue',
              ),
              const Spacer(),
              TextButtonWrapper(
                title: 'Remember Password?',
                nameButton: 'Sign in',
                onTap: () => Navigator.pushNamed(context, '/login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

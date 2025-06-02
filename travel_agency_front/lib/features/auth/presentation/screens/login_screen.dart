import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';
import 'package:travel_agency_front/features/application/presentation/widgets/load_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_formfield.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/text_form_wrapper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void onLogin() {
      if (formKey.currentState!.validate()) {
        context.read<AuthBloc>().add(LoginEvent(
              email: emailController.text,
              password: passwordController.text,
            ));
      }
    }

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacementNamed(context, '/application');
        } else if (state is AuthVerificationSuccess) {
          print('AuthVerificationSuccess $state');
          Navigator.pushReplacementNamed(context, '/verify');
        } else if (state is AuthError) {
          print(state.message);
          context.read<AuthBloc>().add(const LogoutEvent());
        } else if (state is AuthResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return LoadScreen(
          isLoading: isLoading,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign in',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 50),
                    _buildForm(emailController, passwordController, formKey,
                        context, onLogin),
                    const SizedBox(height: 40),
                    TextButtonWrapper(
                      title: 'Don\'t have an account?',
                      nameButton: 'Sign up',
                      onTap: () => Navigator.pushNamed(context, '/register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildForm(
    TextEditingController emailController,
    TextEditingController passwordController,
    GlobalKey<FormState> formKey,
    BuildContext context,
    VoidCallback onLogin,
  ) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthFormfield(
            controller: emailController,
            label: 'Email',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          AuthFormfield(
            controller: passwordController,
            obscureText: true,
            label: 'Password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot');
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: AppColors.primaryColor),
              )),
          const SizedBox(height: 40),
          AuthButton(
            text: 'Login',
            onTap: onLogin,
          ),
        ],
      ),
    );
  }
}


/*
{
	"email":"admin@gmail.com",
	"password":"12345324"
}
 */
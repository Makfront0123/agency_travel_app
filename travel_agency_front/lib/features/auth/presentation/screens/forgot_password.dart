import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/application/presentation/widgets/load_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_formfield.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/text_form_wrapper.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    void onForgot() {
      context.read<AuthBloc>().add(ForgotEvent(email: emailController.text));
    }

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthForgotPasswordOtpSent) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(
              context,
              '/verifyForgot',
              arguments: emailController.text,
            );
          });
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
          context.read<AuthBloc>().add(ResetAuthState());
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return LoadScreen(
          isLoading: isLoading,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Forgot Password',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 50),
                  _buildForm(emailController, formKey, onForgot),
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
      },
    );
  }

  Widget _buildForm(
    TextEditingController emailController,
    GlobalKey<FormState> formKey,
    VoidCallback onForgot,
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
          AuthButton(
            text: 'Continue',
            onTap: onForgot,
          ),
        ],
      ),
    );
  }
}

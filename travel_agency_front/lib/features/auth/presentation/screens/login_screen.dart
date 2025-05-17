import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/auth_button.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/auth_formfield.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/auth_wrapper_text.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/check_remember.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign in',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 50),
            _buildForm(emailController, passwordController),
            const Spacer(),
            TextButtonWrapper(
              title: 'Don\'t have an account?',
              nameButton: 'Sign up',
              onTap: () => Navigator.pushNamed(context, '/register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(TextEditingController emailController,
      TextEditingController passwordController) {
    return Form(
        child: Column(
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
          label: 'Password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        const CheckRemember(),
        const SizedBox(height: 40),
        AuthButton(
          text: 'Login',
          onTap: () {},
        ),
      ],
    ));
  }
}

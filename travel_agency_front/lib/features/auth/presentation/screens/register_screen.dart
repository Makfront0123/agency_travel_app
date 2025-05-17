import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/auth_button.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/auth_formfield.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/auth_wrapper_text.dart';
import 'package:travel_agency_front/features/auth/presentation/widget/check_remember.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign up',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 50),
            _buildForm(emailController, passwordController, usernameController,
                confirmPasswordController),
            const Spacer(),
            TextButtonWrapper(
              title: 'Don\'t have an account?',
              nameButton: 'Sign up',
              onTap: () => Navigator.pushNamed(context, '/login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(
      TextEditingController emailController,
      TextEditingController usernameController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    return Form(
        child: Column(
      children: [
        AuthFormfield(
          controller: usernameController,
          label: 'Username',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        AuthFormfield(
          controller: confirmPasswordController,
          label: 'Confirm Password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Confirm Password is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        const CheckRemember(),
        const SizedBox(height: 40),
        AuthButton(
          text: 'Register',
          onTap: () {},
        ),
      ],
    ));
  }
}

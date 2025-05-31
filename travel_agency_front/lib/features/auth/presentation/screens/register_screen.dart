import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/application/presentation/widgets/load_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_state.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_button.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_formfield.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/check_remember.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/text_form_wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(RegisterEvent(
            name: nameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            password: passwordController.text,
            confirmPassword: confirmPasswordController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegistrationSuccess) {
          Navigator.pushReplacementNamed(context, '/verify');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return LoadScreen(
            isLoading: isLoading,
            child: Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 30),
                child: _buildRegister(context),
              ),
            ));
      },
    );
  }

  Column _buildRegister(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sign up',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
        const SizedBox(height: 50),
        _buildForm(emailController, nameController, lastNameController,
            passwordController, confirmPasswordController),
        const Spacer(),
        TextButtonWrapper(
          title: 'Don\'t have an account?',
          nameButton: 'Sign up',
          onTap: () => Navigator.pushNamed(context, '/login'),
        ),
      ],
    );
  }

  Widget _buildForm(
      TextEditingController emailController,
      TextEditingController nameController,
      TextEditingController lastNameController,
      TextEditingController passwordController,
      TextEditingController confirmPasswordController) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            AuthFormfield(
              controller: nameController,
              label: 'Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            AuthFormfield(
              controller: lastNameController,
              label: 'LastName',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'LastName is required';
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
              onTap: _onRegister,
            ),
          ],
        ));
  }
}

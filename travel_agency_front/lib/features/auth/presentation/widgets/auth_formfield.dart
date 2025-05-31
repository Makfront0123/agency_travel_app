import 'package:flutter/material.dart';

class AuthFormfield extends StatelessWidget {
  final TextEditingController controller;

  final String? Function(String?)? validator;
  final bool obscureText;
  final String label;
  final TextInputType keyboardType;
  const AuthFormfield(
      {super.key,
      required this.controller,
      required this.label,
      this.validator,
      this.obscureText = false,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        labelStyle: Theme.of(context).textTheme.labelMedium,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

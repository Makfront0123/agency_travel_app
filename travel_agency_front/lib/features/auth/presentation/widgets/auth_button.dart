import 'package:flutter/material.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.onTap, this.text});
  final void Function()? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text ?? '',
            style: const TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}

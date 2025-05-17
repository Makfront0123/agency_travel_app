import 'package:flutter/material.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';

class TextButtonWrapper extends StatelessWidget {
  const TextButtonWrapper({
    super.key,
    required this.title,
    required this.nameButton,
    this.onTap,
  });
  final String title;
  final String nameButton;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(nameButton,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.primaryColor)),
        )
      ],
    );
  }
}

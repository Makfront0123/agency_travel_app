import 'package:flutter/material.dart';
import 'package:travel_agency_front/core/theme/app_colors.dart';

class CheckRemember extends StatelessWidget {
  const CheckRemember({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.check_circle_outline,
            color: AppColors.primaryColor, size: 20),
        SizedBox(width: 10),
        Text('Remember me',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
      ],
    );
  }
}

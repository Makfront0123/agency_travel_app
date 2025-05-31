import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_formfield.dart';

class EntityFormContent extends StatelessWidget {
  const EntityFormContent({
    super.key,
    required this.controller02,
    required this.controller01,
    required this.name,
    required this.inputTitle01,
    required this.inputTitle02,
  });

  final TextEditingController controller02;
  final TextEditingController controller01;
  final String name;
  final String inputTitle01;
  final String inputTitle02;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        AuthFormfield(controller: controller01, label: inputTitle01),
        const SizedBox(height: 15),
        AuthFormfield(controller: controller02, label: inputTitle02),
        const SizedBox(height: 15),
      ],
    );
  }
}

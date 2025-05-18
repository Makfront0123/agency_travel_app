import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_container.dart';

class AuthBody extends StatelessWidget {
  const AuthBody(
      {super.key, required this.child, this.showSocialButtons = true});
  final Widget child;
  final bool showSocialButtons;

  @override
  Widget build(BuildContext context) {
    final queryW = MediaQuery.of(context).size.width;
    final queryH = MediaQuery.of(context).size.height * .85;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthContainer(
                height: queryH * .91, width: queryW * .9, child: child),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

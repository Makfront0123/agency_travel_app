import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_agency_front/core/animations/animations.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key, required this.isLoading, required this.child});
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (isLoading) _buildLoadContent(),
          if (!isLoading) child,
        ],
      ),
    );
  }

  Positioned _buildLoadContent() {
    return Positioned.fill(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Animations.loadingAnimation,
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

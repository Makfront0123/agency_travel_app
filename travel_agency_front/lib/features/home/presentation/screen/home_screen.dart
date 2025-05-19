import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      context.read<AuthBloc>().add(const LogoutEvent());
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Home'),
            GestureDetector(
              onTap: logout,
              child: const Row(
                children: [
                  Icon(Icons.logout),
                  Text('Logout'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

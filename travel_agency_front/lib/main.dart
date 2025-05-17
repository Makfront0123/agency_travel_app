import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/app/app_provider.dart';
import 'package:travel_agency_front/app/router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppProvider.allProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.wrapperRoute,
        routes: AppRouter.routes,
      ),
    );
  }
}

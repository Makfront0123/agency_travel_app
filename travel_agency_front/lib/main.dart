import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/app/app_initialize.dart';
import 'package:travel_agency_front/app/app_provider.dart';
import 'package:travel_agency_front/app/router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await initApp();
  runApp(MultiBlocProvider(
      providers: AppProvider.allprovider, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.wrapperRoute,
      routes: AppRouter.routes,
    );
  }
}

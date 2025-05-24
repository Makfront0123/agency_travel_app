import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:travel_agency_front/app/app_provider.dart';
import 'package:travel_agency_front/app/router.dart';

void main() async {
  await initializeDateFormatting('es_ES', null);
  runApp(MultiBlocProvider(
      providers: AppProvider.allprovider, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.wrapperRoute,
      routes: AppRouter.routes,
    );
  }
}

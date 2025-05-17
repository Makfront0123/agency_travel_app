import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/application/presentation/blocs/application_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';

class AppProvider {
  static get allProviders => [
        BlocProvider(create: (context) => ApplicationBloc()),
        BlocProvider(create: (context) => AuthBloc()),
      ];
}

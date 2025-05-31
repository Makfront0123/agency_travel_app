import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_agency_front/features/application/presentation/blocs/application_bloc.dart';
import 'package:travel_agency_front/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:travel_agency_front/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/forgot_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/login_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/logout_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/register_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/resend_otp_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/resend_otp_forgot.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/reset_auth.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/verify_forgot.dart';
import 'package:travel_agency_front/features/auth/domain/usecases/verify_otp_user.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:travel_agency_front/features/auth/presentation/blocs/auth_event.dart';
import 'package:travel_agency_front/features/auth/services/storage_services.dart';
import 'package:travel_agency_front/features/home/data/datasources/home_api_services.dart';
import 'package:travel_agency_front/features/home/data/repository/home_repository_impl.dart';
import 'package:travel_agency_front/features/home/domain/usecases/get_all_airports.dart';
import 'package:travel_agency_front/features/home/domain/usecases/load_flight_cities.dart';
import 'package:travel_agency_front/features/home/domain/usecases/search_flights.dart';
import 'package:travel_agency_front/features/home/presentation/blocs/home_bloc.dart';
import 'package:travel_agency_front/features/payment/data/datasources/payment_api_service.dart';
import 'package:travel_agency_front/features/payment/data/datasources/paypal_api_service.dart';
import 'package:travel_agency_front/features/payment/data/datasources/stripe_api_service.dart';
import 'package:travel_agency_front/features/payment/data/repository/payment_repository_impl.dart';
import 'package:travel_agency_front/features/payment/domain/repository/payment_repository.dart';
import 'package:travel_agency_front/features/reservation/data/datasources/reservation_api_services.dart';
import 'package:travel_agency_front/features/reservation/data/repository/reservation_repository_impl.dart';
import 'package:travel_agency_front/features/reservation/domain/usecase/get_reservation.dart';
import 'package:travel_agency_front/features/reservation/domain/usecase/submit_reservation.dart';
import 'package:travel_agency_front/features/reservation/presentation/blocs/reservation_bloc.dart';

class AppProvider {
  static get allprovider => [
        /// Networking
        RepositoryProvider(create: (_) => Dio()),

        /// Auth
        RepositoryProvider(
          create: (context) =>
              AuthApiService(context.read<Dio>(), 'http://10.0.2.2:8080'),
        ),
        RepositoryProvider(
          create: (context) =>
              AuthRepositoryImpl(context.read<AuthApiService>()),
        ),
        RepositoryProvider(
            create: (context) => ResendOtp(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                ResendOtpForgot(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) => ResetAuth(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                VerifyAccount(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(create: (context) => StorageService()),
        RepositoryProvider(
            create: (context) =>
                VerifyForgot(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                ForgotAuth(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                RegisterUser(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) => LoginUser(context.read<AuthRepositoryImpl>())),
        RepositoryProvider(
            create: (context) =>
                LogoutUser(context.read<AuthRepositoryImpl>())),

        BlocProvider(
          create: (context) => AuthBloc(
            storageService: context.read<StorageService>(),
            resendOtpForgot: context.read<ResendOtpForgot>(),
            resendOtp: context.read<ResendOtp>(),
            verifyForgot: context.read<VerifyForgot>(),
            resetPassword: context.read<ResetAuth>(),
            forgotPassword: context.read<ForgotAuth>(),
            verifyOtp: context.read<VerifyAccount>(),
            registerUser: context.read<RegisterUser>(),
            loginUser: context.read<LoginUser>(),
            logoutUser: context.read<LogoutUser>(),
          )..add(AppStarted()),
        ),

        // General
        BlocProvider(create: (_) => ApplicationBloc()),

        /// Home
        RepositoryProvider(
          create: (context) =>
              HomeApiService(context.read<Dio>(), 'http://10.0.2.2:8080'),
        ),
        RepositoryProvider(
          create: (context) =>
              HomeRepositoryImpl(context.read<HomeApiService>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetAllAirportsUsecase(context.read<HomeRepositoryImpl>()),
        ),
        RepositoryProvider(
          create: (context) =>
              SearchFlightsUsecase(context.read<HomeRepositoryImpl>()),
        ),
        RepositoryProvider(
          create: (context) =>
              LoadFlightCitiesUsecase(context.read<HomeApiService>()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
            getAllAirportsUsecase: context.read<GetAllAirportsUsecase>(),
            searchFlightsUsecase: context.read<SearchFlightsUsecase>(),
            loadFlightCitiesUsecase: context.read<LoadFlightCitiesUsecase>(),
          ),
        ),

        // Payment services FIRST
        RepositoryProvider(
          create: (context) => PaypalPaymentApiService(),
        ),
        RepositoryProvider(
          create: (context) => StripePaymentApiService(),
        ),
        RepositoryProvider(
          create: (context) =>
              PaymentApiService(context.read<Dio>(), 'http://10.0.2.2:8080'),
        ),
        RepositoryProvider<PaymentRepository>(
          create: (context) => PaymentRepositoryImpl(
            context.read<StripePaymentApiService>(),
            context.read<PaypalPaymentApiService>(),
            context.read<PaymentApiService>(),
          ),
        ),

        // Reservation AFTER PaymentRepository is available
        RepositoryProvider(
          create: (context) => ReservationApiService(
              context.read<Dio>(), 'http://10.0.2.2:8080'),
        ),
        RepositoryProvider(
          create: (context) =>
              ReservationRepositoryImpl(context.read<ReservationApiService>()),
        ),
        RepositoryProvider(
          create: (context) => SubmitReservationUsecase(
              context.read<ReservationRepositoryImpl>()),
        ),
        RepositoryProvider(
          create: (context) =>
              GetReservationUseCase(context.read<ReservationRepositoryImpl>()),
        ),
        BlocProvider(
          create: (context) => ReservationBloc(
            paymentRepository: context.read<PaymentRepository>(),
            submitReservationUsecase: context.read<SubmitReservationUsecase>(),
            getReservationUseCase: context.read<GetReservationUseCase>(),
          ),
        ),
      ];
}

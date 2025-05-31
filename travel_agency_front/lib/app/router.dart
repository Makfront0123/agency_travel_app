import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/application/presentation/application_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/forgot_password.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/login_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/register_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/reset_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/verify_forgot_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:travel_agency_front/features/flight/presentation/screens/flight_details_screen.dart';
import 'package:travel_agency_front/features/flight/presentation/screens/flight_result_screen.dart';
import 'package:travel_agency_front/features/home/presentation/screen/home_screen.dart';
import 'package:travel_agency_front/features/home/presentation/screen/search_screen.dart';
import 'package:travel_agency_front/features/payment/presentation/screen/payment_screen.dart';
import 'package:travel_agency_front/features/payment/presentation/screen/payment_success.dart';
import 'package:travel_agency_front/features/reservation/presentation/screen/reservation_confirm.dart';
import 'package:travel_agency_front/features/reservation/presentation/screen/reservation_screen.dart';

class AppRouter {
  static const String initialRoute = '/';
  static const String wrapperRoute = '/wrapper';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String applicationRoute = '/application';
  static const String forgotRoute = '/forgot';
  static const String verifyRoute = '/verify';
  static const String verifyForgotRoute = '/verifyForgot';
  static const String resetRoute = '/reset';
  static const String flightResultsRoute = '/flightResults';
  static const String flightDetailsRoute = '/flightDetails';
  static const String reservationRoute = '/reservation';
  static const String paymentRoute = '/payment';
  static const String paymentSuccessRoute = '/paymentSuccess';
  static const String searchRoute = '/search';
  static const String reservationConfirmRoute = '/reservationConfirm';

  static Map<String, WidgetBuilder> get routes {
    return {
      initialRoute: (context) => const HomeScreen(),
      flightResultsRoute: (context) => const FlightResultScreen(),
      flightDetailsRoute: (context) => const FlightDetailsScreen(),
      searchRoute: (context) => const SearchScreen(),
      paymentSuccessRoute: (context) => const PaymentSuccess(),
      reservationConfirmRoute: (context) => const ReservationConfirmScreen(),
      paymentRoute: (context) => const PaymentScreen(),
      homeRoute: (context) => const HomeScreen(),
      loginRoute: (context) => const LoginScreen(),
      reservationRoute: (context) => const ReservationScreen(),
      resetRoute: (context) => const ResetScreen(),
      verifyRoute: (context) => const VerifyOtpScreen(),
      verifyForgotRoute: (context) => const VerifyForgotScreen(),
      forgotRoute: (context) => const ForgotPassword(),
      registerRoute: (context) => const RegisterScreen(),
      applicationRoute: (context) => const ApplicationScreen(),
      wrapperRoute: (context) => const AuthWrapper(),
    };
  }
}

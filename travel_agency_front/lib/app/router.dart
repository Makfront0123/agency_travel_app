import 'package:flutter/material.dart';
import 'package:travel_agency_front/features/application/presentation/application_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/forgot_password.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/login_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/register_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/reset_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/verify_forgot_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:travel_agency_front/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:travel_agency_front/features/home/presentation/screen/home_screen.dart';

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

  static Map<String, WidgetBuilder> get routes {
    return {
      initialRoute: (context) => const HomeScreen(),
      homeRoute: (context) => const HomeScreen(),
      loginRoute: (context) => const LoginScreen(),
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

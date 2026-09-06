import 'package:flutter/material.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/signup_screen.dart';
import '../features/auth/otp_screen.dart';
import '../features/auth/forgot_password_screen.dart';
import '../features/main_navigation/main_navigation_screen.dart';
import '../features/send_receive/send_money_screen.dart';
import '../features/send_receive/send_review_screen.dart';
import '../features/send_receive/send_success_screen.dart';
import '../features/send_receive/receive_money_screen.dart';
import '../features/internet/package_details_screen.dart';
import '../features/chat/chat_screen.dart';
import '../features/settings/profile_screen.dart';
import '../features/settings/responsible_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String internet = '/internet';
  static const String packageDetails = '/package-details';
  static const String qr = '/qr';
  static const String history = '/history';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String responsible = '/responsible';
  static const String send = '/send';
  static const String sendReview = '/send-review';
  static const String sendSuccess = '/send-success';
  static const String receive = '/receive';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        login: (context) => const LoginScreen(),
        signup: (context) => const SignupScreen(),
        otp: (context) => const OtpScreen(),
        forgotPassword: (context) => const ForgotPasswordScreen(),
        home: (context) => const MainNavigationScreen(initialIndex: 0),
        internet: (context) => const MainNavigationScreen(initialIndex: 1),
        packageDetails: (context) => const PackageDetailsScreen(),
        qr: (context) => const MainNavigationScreen(initialIndex: 2),
        history: (context) => const MainNavigationScreen(initialIndex: 3),
        chat: (context) => const ChatScreen(),
        settings: (context) => const MainNavigationScreen(initialIndex: 4),
        profile: (context) => const ProfileScreen(),
        responsible: (context) => const ResponsibleScreen(),
        send: (context) => const SendMoneyScreen(),
        sendReview: (context) => const SendReviewScreen(),
        sendSuccess: (context) => const SendSuccessScreen(),
        receive: (context) => const ReceiveMoneyScreen(),
      };
}

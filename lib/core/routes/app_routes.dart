import 'package:figma_news_app/feature/home/home_view.dart';
import 'package:figma_news_app/feature/login/login_view.dart';
import 'package:figma_news_app/feature/onboard/onboard_view.dart';
import 'package:figma_news_app/feature/signup/signup_view.dart';
import 'package:figma_news_app/feature/splash/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboard = '/onboard';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboard:
        return MaterialPageRoute(builder: (_) => const OnboardView());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      default:
        throw const FormatException("Route not found! Check routes again.");
    }
  }
}

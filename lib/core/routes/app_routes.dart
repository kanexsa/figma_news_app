import 'package:figma_news_app/feature/onboard/onboard_view.dart';
import 'package:figma_news_app/feature/splash/splash_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboard = '/onboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboard:
        return MaterialPageRoute(builder: (_) => const OnboardView());
      default:
        throw const FormatException("Route not found! Check routes again.");
    }
  }
}

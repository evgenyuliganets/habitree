// ===========================
// ✅ Clean Navigator 1.0 Setup (With _buildPage)
// ===========================

import 'package:flutter/material.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/onboarding/onboarding_language_page.dart';
import 'package:habitree/presentation/onboarding/onboarding_page.dart';
import 'package:habitree/presentation/splash/splash_page.dart';
import 'package:habitree/routes/route_paths.dart';
import 'package:habitree/routes/routes_error_page.dart';

class RouteGenerator {
  factory RouteGenerator() => _instance;

  RouteGenerator._internal();

  static final RouteGenerator _instance = RouteGenerator._internal();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RoutePaths.splash:
        return _buildPage(const SplashPage(), args);

      case RoutePaths.onboarding:
        if (args is! String) return _errorRoute(settings.name);
        return _buildPage(OnboardingPage(language: args), args);

      case RoutePaths.onboardingLanguage:
        if (args is! String) return _errorRoute(settings.name);
        return _buildPage(OnboardingLanguagePage(langName: args), args);

      default:
        return _errorRoute(settings.name);
    }
  }

  Route<dynamic> _buildPage(Widget page, Object? args) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      settings: RouteSettings(arguments: args),
    );
  }

  Route<dynamic> _errorRoute(String? route) {
    return MaterialPageRoute<dynamic>(
      builder: (context) => RoutesErrorPage(routeName: route),
      settings: const RouteSettings(name: '/error'),
    );
  }
}

// ===========================
// ✅ Clean Navigator 1.0 Setup (With _buildPage)
// ===========================

import 'package:flutter/material.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/auth/screens/auth_page.dart';
import 'package:habitree/presentation/auth/screens/confirm_otp_page.dart';
import 'package:habitree/presentation/create_habbit/create_habbit_page.dart';
import 'package:habitree/presentation/create_habbit/habbit_filling_page.dart';
import 'package:habitree/presentation/dashboard/dashboard_page.dart';
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
        return _buildPage(OnboardingPage(language: args! as String), args);

      case RoutePaths.language:
        return _buildPage(
          OnboardingLanguagePage(langName: args! as String),
          args,
        );

      case RoutePaths.auth:
        return _buildPage(const AuthPage(), args);

      case RoutePaths.confirmOtp:
        return _buildPage(
          ConfirmOtpPage(
            email: args! as String,
          ),
          args,
        );

      case RoutePaths.home:
        return _buildPage(
          const DashboardPage(),
          args,
        );

      case RoutePaths.createHabit:
        return _buildPage(
          const CreateHabitPage(),
          args,
        );

      case RoutePaths.habitCreationFilling:
        return _buildPage(
          const HabitCreationFillingPage(),
          args,
        );

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

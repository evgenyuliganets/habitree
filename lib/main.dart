import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/theme/app_theme.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/core/theme/extensions/app_theme_extension.dart';
import 'package:habitree/core/theme/extensions/theme_extension.dart';
import 'package:habitree/di/di.dart';
import 'package:habitree/i18n/strings.g.dart';
import 'package:habitree/routes/route_generator.dart';
import 'package:habitree/routes/route_paths.dart';

/// Entry point of the application.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  configureDependencies();
  runApp(TranslationProvider(child: const ProviderScope(child: HabitreeApp())));
}

/// Root widget of the Habitree app.
class HabitreeApp extends StatefulWidget {
  const HabitreeApp({super.key});

  @override
  State<HabitreeApp> createState() => _HabitreeAppState();
}

class _HabitreeAppState extends State<HabitreeApp> {
  ThemeMode? _themeMode;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      final isDarkMode = _themeMode == ThemeMode.dark;
      updateSystemUIOverlay(isDarkMode: isDarkMode);
    });
  }

  void updateSystemUIOverlay({required bool isDarkMode}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isDark = _themeMode == ThemeMode.dark ||
        (_themeMode == null && platformBrightness == Brightness.dark);
    updateSystemUIOverlay(isDarkMode: isDark);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstants.designSize,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Habitree',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode ?? ThemeMode.system,
          builder: (BuildContext context, Widget? child) {
            final darkMode = (_themeMode == ThemeMode.dark) ||
                (_themeMode == null &&
                    WidgetsBinding
                            .instance.platformDispatcher.platformBrightness ==
                        Brightness.dark);
            return Stack(
              children: [
                child!,
                Positioned(
                  top: 40.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: _toggleTheme,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: context.theme
                            .extension<AppThemeExtension>()!
                            .borderColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        darkMode ? 'Light ☀️' : 'Dark 🌙',
                        style: context.bodySmall.copyWith(
                          color: context.themeExtension.lightGrayColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          initialRoute: RoutePaths.splash,
          onGenerateRoute: RouteGenerator().generateRoute,
        );
      },
    );
  }
}

// class _HabitreeAppState extends State<HabitreeApp> {
//   ThemeMode? _themeMode;
//
//   void _toggleTheme() {
//     setState(() {
//       _themeMode =
//       _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: AppConstants.designSize,
//       builder: (context, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Habitree',
//           theme: AppTheme.lightTheme,
//           darkTheme: AppTheme.darkTheme,
//           home: child,
//           initialRoute: '/splash',
//           onGenerateRoute: RouteGenerator().generateRoute,
//         );
//       },
//     );
//   }
// }

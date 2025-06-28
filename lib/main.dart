import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/theme/app_theme.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/di/di.dart';
import 'package:habitree/routes/route_generator.dart';
import 'package:habitree/routes/route_paths.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// Entry point of the application.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  configureDependencies();
  runApp(TranslationProvider(child: const ProviderScope(child: HabitreeApp())));
}

/// Root widget of the Habitree app.
class HabitreeApp extends ConsumerStatefulWidget {
  const HabitreeApp({super.key});

  @override
  ConsumerState<HabitreeApp> createState() => _HabitreeAppState();
}

class _HabitreeAppState extends ConsumerState<HabitreeApp> {
  @override
  void initState() {
    super.initState();
    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final currentMode = ref.read(themeModeProvider);

    final isDark = currentMode == ThemeMode.dark ||
        (currentMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);

    updateSystemUIOverlay(isDarkMode: isDark);
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
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstants.designSize,
      builder: (context, child) {
        return MaterialApp(
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: AppLocaleUtils.supportedLocales,
          locale: TranslationProvider.of(context).flutterLocale,
          debugShowCheckedModeBanner: false,
          title: 'Habitree',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ref.watch(themeModeProvider) ?? ThemeMode.system,
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

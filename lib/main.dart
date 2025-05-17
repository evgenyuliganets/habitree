import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/theme/app_theme.dart';
import 'package:habitree/routes/route_generator.dart';

/// Entry point of the application.
void main() {
  runApp(const HabitreeApp());
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstants.designSize,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Habitree',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: _themeMode ?? ThemeMode.system,
                home: child,
                initialRoute: '/splash',
                onGenerateRoute: RouteGenerator().generateRoute,
              ),
              // Debug toggle overlay
              Positioned(
                top: 40,
                right: 12,
                child: GestureDetector(
                  onTap: _toggleTheme,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _themeMode == ThemeMode.light ? 'Light ☀️' : 'Dark 🌙',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

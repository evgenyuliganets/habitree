import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habitree/core/constants/constants.dart';
import 'package:habitree/core/extensions/text_theme_extensions.dart';
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Habitree',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode ?? ThemeMode.system,
           builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                child!,
                Positioned(
                  top: 40.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: _toggleTheme,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        _themeMode == ThemeMode.light
                            ? 'Light ☀️'
                            : 'Dark 🌙',
                        style: context.bodySmall,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          initialRoute: '/splash',
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

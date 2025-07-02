import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/main.dart';
import 'package:habitree/presentation/auth/providers/auth_notifier.dart';
import 'package:habitree/presentation/widgets/language_selector.dart';
import 'package:habitree/routes/route_paths.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  void _toggleTheme() {
    final current = ref.read(themeModeProvider);
    final newMode =
        current == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    ref.read(themeModeProvider.notifier).state = newMode;

    final isDarkMode = newMode == ThemeMode.dark;
    updateSystemUIOverlay(isDarkMode: isDarkMode);
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
    final themeMode = ref.watch(themeModeProvider);
    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final darkMode = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LanguageSelector(),
                //logout button
                ElevatedButton(
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).signOut().then((e) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        RoutePaths.auth,
                        (route) => false,
                      );
                    });
                  },
                  child: Text(context.t.general.logout),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.h,
            right: 12.w,
            child: GestureDetector(
              onTap: _toggleTheme,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color:
                      context.theme.extension<AppThemeExtension>()!.borderColor,
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
      ),
    );
  }
}

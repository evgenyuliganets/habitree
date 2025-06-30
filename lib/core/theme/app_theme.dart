import 'package:habitree/core/theme/app_text_theme.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      dialogTheme: DialogTheme(
        titleTextStyle: habitreeTextTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide(
            // to keep if changed in the future
            // ignore: avoid_redundant_argument_values
            color: AppColors.black,
            width: 1.w,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primaryDark,
        secondary: AppColors.accent,
        surface: AppColors.background,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: habitreeTextTheme.apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.textPrimary,
        selectionColor: AppColors.black.withValues(alpha: 0.2),
        selectionHandleColor: AppColors.black.withValues(alpha: 0.2),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        hintStyle: habitreeTextTheme.bodyMedium
            ?.copyWith(color: AppColors.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            width: 1.5.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1.5.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1.5.w,
          ),
        ),
        errorStyle:
            habitreeTextTheme.bodySmall?.copyWith(color: AppColors.error),
      ),
      extensions: const [
        AppThemeExtension(
          borderColor: AppColors.black,
          lightGrayColor: AppColors.lightGrayLight,
          grayColor: AppColors.grayLight,
          grayBorderColor: AppColors.lightGrayBorder,
          grayBorder10: AppColors.lightGrayBorder10,
          grayBorder15: AppColors.lightGrayBorder15,
          grayBorder20: AppColors.lightGrayBorder20,
          grayBorder30: AppColors.lightGrayBorder30,
        ),
        SkeletonizerConfigData(
          effect: ShimmerEffect(
            baseColor: AppColors.lightGrayBorder,
            highlightColor: AppColors.lightGrayBorder10,
          ),
        ),
      ],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.standard,
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textSecondary;
            }
            return AppColors.black;
          }),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          textStyle: WidgetStateProperty.all(habitreeTextTheme.headlineMedium),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          minimumSize: WidgetStateProperty.all(Size.fromHeight(48.h)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.standard,
          side: WidgetStateProperty.all(
            const BorderSide(),
          ),
          foregroundColor: WidgetStateProperty.all(AppColors.black),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.border;
            }
            return Colors.transparent;
          }),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          ),
          textStyle: WidgetStateProperty.all(habitreeTextTheme.headlineMedium),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          minimumSize: WidgetStateProperty.all(Size.fromHeight(48.h)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      dialogTheme: DialogTheme(
        titleTextStyle: habitreeTextTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side:  BorderSide(
            color: AppColors.white,
            width: 1.w,
          ),
        ),
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.darkBackground,
        onSurface: AppColors.white,
      ),
      textTheme: habitreeTextTheme.apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        hintStyle: habitreeTextTheme.bodyMedium
            ?.copyWith(color: AppColors.textTertiary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.white, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.white, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.white, width: 1.5.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.error, width: 1.5.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.error, width: 1.5.w),
        ),
        errorStyle:
            habitreeTextTheme.bodySmall?.copyWith(color: AppColors.error),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.white,
        selectionColor: AppColors.accent.withValues(alpha: 0.2),
        selectionHandleColor: AppColors.white,
      ),
      extensions: const [
        AppThemeExtension(
          borderColor: AppColors.white,
          lightGrayColor: AppColors.lightGrayDark,
          grayColor: AppColors.grayDark,
          grayBorderColor: AppColors.darkGrayBorder,
          grayBorder10: AppColors.darkGrayBorder10,
          grayBorder15: AppColors.darkGrayBorder15,
          grayBorder20: AppColors.darkGrayBorder20,
          grayBorder30: AppColors.darkGrayBorder30,
        ),
        SkeletonizerConfigData(
          effect: ShimmerEffect(
            baseColor: AppColors.lightGrayBorder,
            highlightColor: AppColors.lightGrayBorder10,
          ),
        ),
      ],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.standard,
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textTertiary;
            }
            return Colors.white;
          }),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          ),
          foregroundColor: WidgetStateProperty.all(AppColors.black),
          textStyle: WidgetStateProperty.all(habitreeTextTheme.headlineMedium),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          minimumSize: WidgetStateProperty.all(Size.fromHeight(48.h)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.standard,
          side: WidgetStateProperty.all(
            const BorderSide(color: Colors.white),
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.white.withValues(alpha: 0.12);
            }
            return Colors.transparent;
          }),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          ),
          textStyle: WidgetStateProperty.all(habitreeTextTheme.headlineMedium),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          minimumSize: WidgetStateProperty.all(Size.fromHeight(48.h)),
        ),
      ),
    );
  }
}

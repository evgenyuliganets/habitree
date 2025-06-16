import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.borderColor,
    required this.lightGrayColor,
    required this.grayColor,
  });

  final Color borderColor;
  final Color lightGrayColor;
  final Color grayColor;

  @override
  AppThemeExtension copyWith({
    Color? borderColor,
    Color? lightGrayColor,
    Color? grayColor,
  }) {
    return AppThemeExtension(
      borderColor: borderColor ?? this.borderColor,
      lightGrayColor: lightGrayColor ?? this.lightGrayColor,
      grayColor: grayColor ?? this.grayColor,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      grayColor: Color.lerp(grayColor, other.grayColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      lightGrayColor: Color.lerp(lightGrayColor, other.lightGrayColor, t)!,
    );
  }
}

import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.borderColor,
    required this.lightGrayColor,
    required this.grayColor,
    required this.grayBorderColor,
    required this.grayBorder10,
    required this.grayBorder15,
    required this.grayBorder20,
    required this.grayBorder30,
  });

  final Color borderColor;
  final Color lightGrayColor;
  final Color grayColor;
  final Color grayBorderColor;
  final Color grayBorder10;
  final Color grayBorder15;
  final Color grayBorder20;
  final Color grayBorder30;

  @override
  AppThemeExtension copyWith({
    Color? borderColor,
    Color? lightGrayColor,
    Color? grayColor,
    Color? grayBorderColor,
    Color? grayBorder10,
    Color? grayBorder15,
    Color? grayBorder20,
    Color? grayBorder30,
  }) {
    return AppThemeExtension(
      borderColor: borderColor ?? this.borderColor,
      lightGrayColor: lightGrayColor ?? this.lightGrayColor,
      grayColor: grayColor ?? this.grayColor,
      grayBorderColor: grayBorderColor ?? this.grayBorderColor,
      grayBorder10: grayBorder10 ?? this.grayBorder10,
      grayBorder15: grayBorder15 ?? this.grayBorder15,
      grayBorder20: grayBorder20 ?? this.grayBorder20,
      grayBorder30: grayBorder30 ?? this.grayBorder30,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      grayColor: Color.lerp(grayColor, other.grayColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      lightGrayColor: Color.lerp(lightGrayColor, other.lightGrayColor, t)!,
      grayBorderColor: Color.lerp(grayBorderColor, other.grayBorderColor, t)!,
      grayBorder10: Color.lerp(grayBorder10, other.grayBorder10, t)!,
      grayBorder15: Color.lerp(grayBorder15, other.grayBorder15, t)!,
      grayBorder20: Color.lerp(grayBorder20, other.grayBorder20, t)!,
      grayBorder30: Color.lerp(grayBorder30, other.grayBorder30, t)!,
    );
  }
}

extension MatColor on Color {
  WidgetStateProperty<Color> get matColor => WidgetStateProperty.all(this);
}

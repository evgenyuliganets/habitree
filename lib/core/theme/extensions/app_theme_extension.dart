import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {

  const AppThemeExtension({required this.borderColor});
  final Color borderColor;

  @override
  AppThemeExtension copyWith({Color? borderColor}) {
    return AppThemeExtension(borderColor: borderColor ?? this.borderColor);
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
    );
  }
}

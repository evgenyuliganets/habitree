import 'package:flutter/material.dart';
import 'package:habitree/core/theme/extensions/app_theme_extension.dart';

extension AppThemeGetter on BuildContext {
  AppThemeExtension get themeExtension =>
      Theme.of(this).extension<AppThemeExtension>()!;
}

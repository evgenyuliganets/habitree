import 'package:flutter/material.dart';

extension TextThemeX on BuildContext {
  TextStyle get headlineLarge => theme.textTheme.headlineLarge!;

  TextStyle get headlineMedium => theme.textTheme.headlineMedium!;

  TextStyle get titleMedium => theme.textTheme.titleMedium!;

  TextStyle get bodyLarge => theme.textTheme.bodyLarge!;

  TextStyle get bodyMedium => theme.textTheme.bodyMedium!;

  TextStyle get bodySmall => theme.textTheme.bodySmall!;

  TextStyle get labelSmall => theme.textTheme.labelSmall!;

  ThemeData get theme => Theme.of(this);
}

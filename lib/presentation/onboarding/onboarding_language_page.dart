import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/routes/route_paths.dart';

class OnboardingLanguagePage extends StatelessWidget {
  const OnboardingLanguagePage({required this.langName, super.key});

  static String path = RoutePaths.onboardingLanguage;

  final String langName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.onboardingLanguageTitle,
          style: context.headlineMedium,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          '${AppStrings.onboardingLanguageValue} $langName',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

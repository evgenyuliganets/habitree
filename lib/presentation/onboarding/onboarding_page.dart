import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/routes/route_paths.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({required this.language, super.key});

  static String path = RoutePaths.onboarding;

  final String language;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          AppStrings.onboardingTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          '${AppStrings.onboardingSelectedLang} $language',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}

import 'package:habitree/core/theme/export_ui_styleguide.dart';

class GreetingUi extends StatelessWidget {
  const GreetingUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      // TODO(evgeny): Replace 'User' with actual user name if available
      context.t.home.welcome(name: 'User'),
      textAlign: TextAlign.center,
      style: context.headlineMedium.copyWith(
        fontWeight: FontWeight.w600,
        color: context.theme.colorScheme.onSurface,
      ),
    );
  }
}

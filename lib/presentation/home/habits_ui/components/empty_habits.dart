import 'package:habitree/core/theme/export_ui_styleguide.dart';

class EmptyHabitsUi extends StatelessWidget {
  const EmptyHabitsUi({required this.isToday, super.key});

  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final textToday = '\n${t.home.restAndChallenge}'
        '\n${t.home.selfChallenge}'
        '\n${t.home.selfChallengeDesc}';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 64.h),
      child: Center(
        child: Text(
         isToday? textToday:'\n${t.home.createGoal}',
          textAlign: TextAlign.center,
          style: context.headlineMedium.copyWith(
            height: 28 / 20,
          ),
        ),
      ),
    );
  }
}

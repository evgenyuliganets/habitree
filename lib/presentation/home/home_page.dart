import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/home/greeting_ui.dart';
import 'package:habitree/presentation/home/habits_ui/habits_ui.dart';
import 'package:habitree/presentation/home/streak_ui/streak_ui.dart';
import 'package:habitree/presentation/home/week_day/week_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const WeekUi(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 40.w,
                      bottom: 24.w,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: const GreetingUi(),
                  ),
                  const StreakUi(),
                  const HabitsUi(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

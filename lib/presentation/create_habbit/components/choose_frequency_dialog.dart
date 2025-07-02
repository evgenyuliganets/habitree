import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/create_habbit/components/common_alert_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/shared/widgets/active/checkbox_tile.dart';
import 'package:habitree/shared/widgets/static/double_circle.dart';

Future<dynamic> showChooseFrequencyDialog(
  BuildContext context,
  void Function(BuildContext) onNext,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final draft = ref.watch(createHabitProvider);
          final isOneTime = draft.isOneTime;
          return CommonAlertDialog(
            text: 'Як  довго  хочеш    виконувати звичку?',
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HabitreeCheckboxTile(
                  title: 'Це одноразово',
                  value: isOneTime,
                  onChanged: (value) => ref
                      .read(createHabitProvider.notifier)
                      .setIsOneTime(value: true),
                ),
                SizedBox(height: 16.h),
                HabitreeCheckboxTile(
                  title: 'Це довгостроково ',
                  value: !isOneTime,
                  onChanged: (value) => ref
                      .read(createHabitProvider.notifier)
                      .setIsOneTime(value: false),
                ),
              ],
            ),
            onNext: onNext,
          );
        },
      );
    },
  );
}

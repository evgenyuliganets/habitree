import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/create_habbit/components/common_alert_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/shared/widgets/active/checkbox_tile.dart';

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
            text: context.t.habitCreationFilling.goalTypeTitle,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HabitreeCheckboxTile(
                  title: context.t.habitCreationFilling.goalOnce,
                  value: isOneTime,
                  onChanged: (value) => ref
                      .read(createHabitProvider.notifier)
                      .setIsOneTime(value: true),
                ),
                SizedBox(height: 16.h),
                HabitreeCheckboxTile(
                  title: context.t.habitCreationFilling.goalLongTerm,
                  value: isOneTime == null ? null : !isOneTime,
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

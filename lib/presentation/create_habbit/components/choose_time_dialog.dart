import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/create_habbit/components/common_alert_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';

Future<dynamic> showChooseTimeDialog(
  BuildContext context,
  void Function(BuildContext) onNext,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final draft = ref.watch(createHabitProvider);
          final time = draft.time ?? const TimeOfDay(hour: 9, minute: 0);
          return CommonAlertDialog(
            text: context.t.habitCreationFilling.timeLabel,
            content: SizedBox(
              width: double.maxFinite,
              height: 220.h,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: time.toDuration,
                onTimerDurationChanged: (duration) {
                  ref
                      .read(createHabitProvider.notifier)
                      .setTime(duration.toTimeOfDay);
                },
              ),
            ),
            onNext: (context) {
              ref.read(createHabitProvider.notifier).setTime(time);
              onNext(context);
            },
          );
        },
      );
    },
  );
}

extension on Duration {
  TimeOfDay get toTimeOfDay => TimeOfDay(
        hour: inHours,
        minute: inMinutes.remainder(60),
      );
}

extension on TimeOfDay {
  Duration get toDuration => Duration(
        hours: hour,
        minutes: minute,
      );
}

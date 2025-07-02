import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/domain/entities/habit/habit.dart';
import 'package:habitree/presentation/create_habbit/components/common_alert_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/shared/widgets/active/checkbox_tile.dart';
import 'package:habitree/shared/widgets/static/double_circle.dart';

Future<dynamic> showChooseScheduleCDialog(
  BuildContext context,
  void Function(BuildContext) onNext,
) {
  return showDialog(
    context: context,
    builder: (context) {
      final screenWidth = MediaQuery.of(context).size.width;
      return Consumer(
        builder: (context, ref, child) {
          final draft = ref.watch(createHabitProvider);
          final isDaily = draft.isDaily;
          return CommonAlertDialog(
            text: 'Який графік бажаєш?',
            content: SizedBox(
              width: screenWidth - 32.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: Weekday.values
                        .asMap()
                        .map(
                          (k, v) {
                            return MapEntry(
                              k,
                              HabitreeCheckboxTile(
                                direction: Axis.vertical,
                                title:
                                    v.getLabel(Localizations.localeOf(context)),
                                value: draft.repeatDays.contains(v),
                                onChanged: (value) => ref
                                    .read(createHabitProvider.notifier)
                                    .toggleDay(day: v, value: value ?? false),
                              ),
                            );
                          },
                        )
                        .values
                        .toList(),
                  ),
                  SizedBox(height: 16.h),
                  HabitreeCheckboxTile(
                    title: 'Щодня',
                    value: isDaily,
                    onChanged: (value) => ref
                        .read(createHabitProvider.notifier)
                        .setIsDaily(value: value ?? false),
                  ),
                ],
              ),
            ),
            onNext: onNext,
          );
        },
      );
    },
  );
}
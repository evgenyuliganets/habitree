import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/domain/entities/habit/habit.dart';
import 'package:habitree/presentation/create_habbit/components/common_alert_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/shared/widgets/active/checkbox_tile.dart';

Future<dynamic> showChooseTermDialog(
  BuildContext context,
  void Function(BuildContext) onNext,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final draft = ref.watch(createHabitProvider);
          final term = draft.term;
          return CommonAlertDialog(
            text: context.t.habitCreationFilling.termTitle,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: HabitTerm.values
                  .asMap()
                  .map(
                    (k, v) => MapEntry(
                      k,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: HabitreeCheckboxTile(
                          title: v.title(context.t),
                          value: term == v,
                          onChanged: (value) {
                            ref.read(createHabitProvider.notifier).setTerm(v);
                          },
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
            onNext: onNext,
          );
        },
      );
    },
  );
}

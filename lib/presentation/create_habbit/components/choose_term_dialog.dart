import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/create_habbit/components/common_alert_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/shared/widgets/static/double_circle.dart';

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
            text: 'Обери термін виконання звички',
            content: SizedBox(),
            // content: Wrap(
            //   alignment: WrapAlignment.center,
            //   children: HabitColors.values
            //       .asMap()
            //       .map(
            //         (k, v) => MapEntry(
            //           k,
            //           Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 5.w),
            //             child: ColorOptionDot(
            //               isSelected: selectedIndex == k,
            //               color: v,
            //               onTap: () => ref
            //                   .read(createHabitProvider.notifier)
            //                   .setColor(v),
            //             ),
            //           ),
            //         ),
            //       )
            //       .values
            //       .toList(),
            // ),
            onNext: onNext,
          );
        },
      );
    },
  );
}

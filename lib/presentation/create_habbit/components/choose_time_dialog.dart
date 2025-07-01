import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/core/theme/habbit_colors.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/shared/widgets/static/double_circle.dart';

Future<dynamic> showChooseTimeDialog(
  BuildContext context,
  void Function(BuildContext) onNext,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          const colors = HabitColors.values;
          final selectedIndex = ref.watch(
            createHabitProvider.select(
              (state) => colors.indexWhere((color) => color == state.color),
            ),
          );
          return AlertDialog(
            contentPadding:
            EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
            titlePadding:
            EdgeInsets.symmetric(horizontal: 32.w).copyWith(top: 32.h),
            title: const Text(
              'Обери час',
              textAlign: TextAlign.center,
            ),
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
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () => onNext(context),
                child: Text(t.general.next),
              ),
            ],
          );
        },
      );
    },
  );
}

class ColorOptionDot extends StatelessWidget {
  const ColorOptionDot({
    required this.isSelected,
    required this.color,
    required this.onTap,
    super.key,
  });

  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? context.themeExtension.borderColor
                : Colors.transparent,
            width: 1.w,
          ),
        ),
        child: DoubleCircle(
          size: 16.w,
          color: color,
          padding: 4.w,
        ),
      ),
    );
  }
}

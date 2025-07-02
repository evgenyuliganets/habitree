import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/core/theme/habbit_colors.dart';
import 'package:habitree/presentation/create_habbit/components/common_alert_dialog.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/shared/widgets/static/double_circle.dart';

Future<dynamic> showChooseColorDialog(
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
          return CommonAlertDialog(
            text: context.t.habitCreationFilling.colorTitle,
            content: Wrap(
              alignment: WrapAlignment.center,
              children: HabitColors.values
                  .asMap()
                  .map(
                    (k, v) => MapEntry(
                      k,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: _ColorOptionDot(
                          isSelected: selectedIndex == k,
                          color: v,
                          onTap: () => ref
                              .read(createHabitProvider.notifier)
                              .setColor(v),
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

class _ColorOptionDot extends StatelessWidget {
  const _ColorOptionDot({
    required this.isSelected,
    required this.color,
    required this.onTap,
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
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
          return AlertDialog(
            contentPadding:
            EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
            titlePadding:
            EdgeInsets.symmetric(horizontal: 32.w).copyWith(top: 32.h),
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            title: const Text(
              'Як  довго  хочеш    виконувати звичку?',
              textAlign: TextAlign.center,
            ),
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/create_habbit/provider/create_habit_notifier.dart';
import 'package:habitree/presentation/create_habbit/provider/utils/default_habit_icons.dart';

Future<dynamic> showChooseIconDialog(
  BuildContext context,
    void Function(BuildContext) onNext,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          const icons = DefaultHabitIcons.all;
          final selectedIndex = ref.watch(
            createHabitProvider.select(
              (state) => icons.indexWhere((icon) => icon == state.emoji),
            ),
          );
          return AlertDialog(
            contentPadding:
            EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
            titlePadding:
            EdgeInsets.symmetric(horizontal: 32.w).copyWith(top: 32.h),
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            title: const Text(
              'Обери іконку для своєї звички',
              textAlign: TextAlign.center,
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.w,
              runSpacing: 8.w,
              children: DefaultHabitIcons.all
                  .asMap()
                  .map(
                    (k, v) => MapEntry(
                      k,
                      ColorOptionDot(
                        isSelected: selectedIndex == k,
                        emoji: v,
                        onTap: () =>
                            ref.read(createHabitProvider.notifier).setEmoji(v),
                      ),
                    ),
                  )
                  .values
                  .toList(),
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
    required this.emoji,
    required this.onTap,
    super.key,
  });

  final bool isSelected;
  final String emoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45.w,
        height: 45.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? context.themeExtension.borderColor
                : Colors.transparent,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: context.displayMedium.copyWith(
              fontSize: 32.sp,
              height: 22 / 32,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

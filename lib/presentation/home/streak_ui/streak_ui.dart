import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/core/theme/extensions/theme_extension.dart';
import 'package:habitree/i18n/strings.g.dart';
import 'package:habitree/presentation/home/streak_ui/components/progress_bar.dart';

class StreakUi extends StatelessWidget {
  const StreakUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 32.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.theme.colorScheme.outline,
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  context.t.home.dailyMotivation,
                  style: context.bodyMedium.copyWith(
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 29.h),
                // TODO(evgeny): Replace with actual streak value
                const SizedBox(
                  width: double.infinity,
                  child: GoalProgressBar(
                    value: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: context.themeExtension.grayBorderColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              context.t.home.dayCounter(number: 1),
              style: context.headlineMedium.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

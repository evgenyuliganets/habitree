import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/shared/widgets/active/checkbox.dart';

class HabitreeCheckboxTile extends StatelessWidget {
  const HabitreeCheckboxTile({
    required this.value,
    required this.onChanged,
    required this.title,
    super.key,
    this.direction = Axis.horizontal,
  });

  final bool value;
  final Axis direction;
  final ValueChanged<bool?> onChanged;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        overlayColor: Colors.transparent.matColor,
        onTap: () => onChanged(!value),
        child: SizedBox(
          height: 40.w,
          child: Row(
            children: [
              HabitreeCheckbox(value: value, onChanged: onChanged),
              SizedBox(width: 8.w),
              Text(
                title,
                style: context.headlineMedium.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        overlayColor: Colors.transparent.matColor,
        onTap: () => onChanged(!value),
        child: SizedBox(
          width: 32.w,
          height: 80.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: context.headlineMedium.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              HabitreeCheckbox(value: value, onChanged: onChanged),

            ],
          ),
        ),
      );
    }
  }
}

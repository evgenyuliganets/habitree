import 'package:habitree/core/theme/export_ui_styleguide.dart';

class GoalProgressBar extends StatelessWidget {
  // 0 → 100

  const GoalProgressBar({
    required this.value,
    super.key,
  });

  final double value;

  @override
  Widget build(BuildContext context) {
    final normalized = (value.clamp(0, 100)) / 100;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border:  Border.all(
            color: context.themeExtension.borderColor,
            width: 1.w,
          ),
        ),
        height: 6.h,
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: normalized,
          child: Container(
            color: context.themeExtension.borderColor,
          ),
        ),
      ),
    );
  }
}

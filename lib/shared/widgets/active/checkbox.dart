import 'package:habitree/core/theme/export_ui_styleguide.dart';

class HabitreeCheckbox extends StatelessWidget {
  const HabitreeCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28.w,
      child: Transform.scale(
        scale: 28.w / 20,
        child: Checkbox(
          value: value ?? false,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

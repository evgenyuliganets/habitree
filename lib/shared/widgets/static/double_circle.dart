import 'package:habitree/core/theme/export_ui_styleguide.dart';

class DoubleCircle extends StatelessWidget {
  const DoubleCircle({
    required this.size,
    required this.color,
    required this.padding,
    super.key,
  });

  final double size;
  final Color color;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 1.w,
        ),
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}

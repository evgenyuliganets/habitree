import 'package:habitree/core/theme/export_ui_styleguide.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    required this.text,
    required this.content,
    required this.onNext,
    super.key,
  });

  final String text;
  final Widget content;
  final void Function(BuildContext) onNext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 32.w),
      titlePadding: EdgeInsets.symmetric(horizontal: 32.w).copyWith(top: 32.h),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      title: Text(
        text,
        textAlign: TextAlign.center,
      ),
      content: content,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          onPressed: () => onNext(context),
          child: Text(t.general.next),
        ),
      ],
    );
  }
}

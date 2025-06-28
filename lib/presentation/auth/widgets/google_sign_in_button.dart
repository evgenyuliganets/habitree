import 'package:flutter_svg/flutter_svg.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.image,
    required this.text,
    required this.textStyle,
    required this.color,
    required this.buttonAction,
    super.key,
  });

  factory SignInButton.google(TextTheme textTheme, VoidCallback buttonAction) {
    return SignInButton(
      image: AuthIcons.googleLogo,
      textStyle: textTheme.titleMedium!.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
      text: '${t.authStart.continueWith} ${t.authStart.continueGoogle}',
      color: Colors.white,
      buttonAction: buttonAction,
    );
  }

  final String image;
  final Color color;
  final String text;
  final VoidCallback buttonAction;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: SizedBox(
        height: 58.w,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
            border: Border.all(
              //to keep if changed in the future
              // ignore: avoid_redundant_argument_values
              color: context.theme.extension<AppThemeExtension>()!.borderColor,
              width: 1.5.w,
            ),
          ),
          child: InkWell(
            onTap: buttonAction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: SvgPicture.asset(
                    image,
                    width: 24.w,
                  ),
                ),
                Text(
                  text,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

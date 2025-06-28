import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/auth/providers/auth_notifier.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmOtpPage extends ConsumerStatefulWidget {
  const ConfirmOtpPage({required this.email, super.key});

  final String email;

  @override
  ConsumerState<ConfirmOtpPage> createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends ConsumerState<ConfirmOtpPage> {
  TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();
  late final String email = widget.email;

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = context.themeExtension.lightGrayColor;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ///back button
            Positioned(
              top: 16.w,
              left: 16.w,
              child: IconButton(
                icon: Icon(Icons.arrow_back, size: 24.w),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 48.w),
                  Text(
                    context.t.authStart.pass6DigitCode,
                    style: context.displayMedium,
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    context.t.authStart.letterWithCodeSent,
                    style: context.headlineMedium,
                  ),
                  SizedBox(height: 32.w),
                  PinCodeTextField(
                    focusNode: focusNode,
                    appContext: context,
                    length: 6,
                    controller: controller,
                    animationType: AnimationType.scale,
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    cursorColor: context.themeExtension.borderColor,
                    onChanged: (_) {},
                    onCompleted: (code) {
                      ref
                          .read(authNotifierProvider.notifier)
                          .confirmOtp(code: code.trim(), email: email);
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 56,
                      fieldWidth: 48,
                      borderWidth: 0,
                      activeBorderWidth: 0,
                      selectedBorderWidth: 0,
                      inactiveBorderWidth: 0,
                      disabledBorderWidth: 0,
                      errorBorderWidth: 0,
                      activeColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      errorBorderColor: Colors.transparent,
                      activeFillColor: fillColor,
                      selectedFillColor: fillColor,
                      inactiveFillColor: fillColor,
                    ),
                    textStyle: context.headlineLarge
                        .copyWith(fontWeight: FontWeight.w500, height: 24 / 20),
                  ),
                  SizedBox(height: 32.w),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(authNotifierProvider.notifier).confirmOtp(
                          code: controller.text.trim(), email: email);
                    },
                    child: Text(context.t.general.kContinue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

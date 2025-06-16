import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/i18n/strings.g.dart';
import 'package:habitree/presentation/auth/providers/auth_notifier.dart';
import 'package:habitree/presentation/auth/providers/auth_state.dart';
import 'package:habitree/presentation/auth/widgets/google_sign_in_button.dart';
import 'package:habitree/presentation/widgets/language_selector.dart';
import 'package:habitree/routes/route_paths.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        },
        authenticated: (_) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RoutePaths.home,
            (route) => false,
          );
        },
        otpSent: (email) {
          Navigator.of(context)
              .pushNamed(RoutePaths.confirmOtp, arguments: email);
        },
        orElse: () {},
      );
    });
    // final state = ref.watch(authNotifierProvider);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton.google(context.theme.textTheme, () {
                    ref.read(authNotifierProvider.notifier).signInWithGoogle();
                  }),
                  SizedBox(height: 32.h),
                  Text(
                    context.t.authStart.or,
                    style: context.theme.textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: context.theme.textTheme.headlineMedium!.color!
                          .withValues(alpha: 0.5),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  TextField(
                    controller: controller,
                    style: context.theme.textTheme.headlineMedium,
                    decoration: InputDecoration(
                      hintText: context.t.authFields.email,
                      hintStyle: context.theme.textTheme.headlineMedium!.copyWith(
                        color: context.theme.textTheme.headlineMedium!.color!
                            .withValues(alpha: 0.5),
                      ),
                    ),
                    onSubmitted: (value) {
                      ref.read(authNotifierProvider.notifier).sendOtpToEmail(value);
                    },
                  ),
                  SizedBox(height: 32.h),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(authNotifierProvider.notifier)
                          .sendOtpToEmail(controller.text);
                    },
                    child: Text(context.t.general.kContinue),
                  ),
                ],
              ),
            ),
          ),

          ///language selector
          Positioned(
            top: 40.h,
            left: 12.w,
            child: const LanguageSelector(),
          ),
        ],
      ),
    );
  }
}

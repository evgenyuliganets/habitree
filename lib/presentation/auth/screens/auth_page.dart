import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/i18n/strings.g.dart';
import 'package:habitree/presentation/auth/providers/auth_notifier.dart';
import 'package:habitree/presentation/auth/providers/auth_state.dart';
import 'package:habitree/presentation/auth/widgets/google_sign_in_button.dart';

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
        orElse: () {},
      );
    });
    return Scaffold(
      body: Center(
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
                context.t.authStart.hello,
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
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(authNotifierProvider.notifier)
                      .sendOtpToEmail(controller.text);
                },
                child: Text(context.t.authStart.continueWith),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

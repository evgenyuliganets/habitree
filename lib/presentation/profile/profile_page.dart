import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/i18n/strings.g.dart';
import 'package:habitree/presentation/auth/providers/auth_notifier.dart';
import 'package:habitree/routes/route_paths.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logout button
            ElevatedButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signOut().then((e) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    RoutePaths.auth,
                    (route) => false,
                  );
                });
              },
              child: Text(context.t.general.logout),
            ),
          ],
        ),
      ),
    );
  }
}

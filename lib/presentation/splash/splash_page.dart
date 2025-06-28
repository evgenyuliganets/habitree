import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/presentation/auth/providers/auth_notifier.dart';
import 'package:habitree/routes/route_paths.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  static const path = RoutePaths.splash;

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final authNotifier = ref.read(authNotifierProvider.notifier);
    await authNotifier.loadCurrentSession();
    // final localDataSource = getIt<AuthLocalDataSource>();
    // await localDataSource.saveAccessToken('423432423542323f23f23f32'
    //     'f23f34f34f34');

    final state = ref.read(authNotifierProvider);
    final session = state.maybeWhen(
      authenticated: (session) => session,
      orElse: () => null,
    );

    if (!mounted) return;

    if (session != null) {
      log('User is already logged in: ${session.accessToken}');
      await Navigator.of(context).pushReplacementNamed(RoutePaths.home);
    } else {
      log('No active session found, redirecting to auth page');
      await Navigator.of(context).pushReplacementNamed(RoutePaths.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

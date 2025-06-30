import 'package:habitree/di/di.dart';
import 'package:habitree/domain/usecases/auth/sign_out_usecase.dart';
import 'package:habitree/routes/route_paths.dart';
import 'package:habitree/shared/utils/navigation/navigation_service.dart';

class AppUtils {
  ///logout the user
  static void logout() {
    getIt<SignOutUseCase>().call();
    NavigationService.navigatorKey.currentState!
        .pushNamedAndRemoveUntil(RoutePaths.auth, (route) => false);
  }
}

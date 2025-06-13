import 'package:get_it/get_it.dart';
import 'package:habitree/di/di.config.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  getIt.init();
}

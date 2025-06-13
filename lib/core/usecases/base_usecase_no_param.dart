import 'package:habitree/core/usecases/base_usecase.dart';

abstract class BaseUseCaseNoParam<TResult> extends BaseUseCase<void, TResult> {
  @override
  Future<TResult?> call([void param]) => super.call(param);
}

import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase.dart';
import 'package:habitree/data/models/habit/create_habit.dart';
import 'package:habitree/domain/repositories/habits/habits_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateHabitUseCase extends BaseUseCase<CreateHabitDto, Result<bool>> {
  CreateHabitUseCase(
    this._repository,
  );

  final HabitsRepository _repository;

  @override
  Future<Result<bool>> execute(CreateHabitDto param) {
    return _repository.createHabit(param);
  }
}

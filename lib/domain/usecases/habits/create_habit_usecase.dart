import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/models/habit/create_habit.dart';
import 'package:habitree/domain/repositories/habits/habits_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateHabitUseCase {
  const CreateHabitUseCase(this._repository);

  final HabitsRepository _repository;

  Future<Result<bool>> call(CreateHabitDto param) {
    return _repository.createHabit(param);
  }
}

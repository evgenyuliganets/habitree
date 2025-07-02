import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/models/habit/create_habit.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';
import 'package:habitree/domain/entities/paginated_list/paginated_list.dart';
import 'package:habitree/domain/usecases/habits/get_habits_status_usecase.dart';
import 'package:habitree/domain/usecases/habits/toggle_done_habbit_usecase.dart';

abstract class HabitsRepository {
  Future<Result<PaginatedList<HabitStatus>>> getHabitsByDate(
    GetHabitsByDateParam param,
  );

  Future<Result<bool>> createHabit(CreateHabitDto param);

  Future<Result<bool>> toggleHabit({required ToggleHabitParam param});
}

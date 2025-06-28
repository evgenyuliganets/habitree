import 'package:habitree/core/result/result.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';
import 'package:habitree/domain/entities/paginated_list/paginated_list.dart';
import 'package:habitree/domain/usecases/habits/get_habits_status_usecase.dart';

abstract class HabitsRemoteDataSource {
  Future<Result<PaginatedList<HabitStatus>>> getHabitsByDate(
    GetHabitsByDateParam param,
  );

  Future<Result<void>> addHabit(HabitStatus habitStatus);
}

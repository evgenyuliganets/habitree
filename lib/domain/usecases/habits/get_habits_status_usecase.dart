import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';
import 'package:habitree/domain/entities/paginated_list/paginated_list.dart';
import 'package:habitree/domain/repositories/habits/habits_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserHabitsByDateUseCase extends BaseUseCase<GetHabitsByDateParam,
    Result<PaginatedList<HabitStatus>>> {
  GetUserHabitsByDateUseCase(this._repository);

  final HabitsRepository _repository;

  @override
  Future<Result<PaginatedList<HabitStatus>>> execute(
    GetHabitsByDateParam param,
  ) {
    return _repository.getHabitsByDate(param);
  }
}

class GetHabitsByDateParam {
  const GetHabitsByDateParam({
    required this.date,
    required this.limit,
    required this.offset,
  });

  final DateTime date;
  final int limit;
  final int offset;
}

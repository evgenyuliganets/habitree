import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/data_sources/habits/remote/habits_remote_datasource.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';
import 'package:habitree/domain/entities/paginated_list/paginated_list.dart';
import 'package:habitree/domain/repositories/habits/habits_repository.dart';
import 'package:habitree/domain/usecases/habits/get_habits_status_usecase.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HabitsRepository)
class HabitRepositoryImpl implements HabitsRepository {
  const HabitRepositoryImpl(this._remote);

  final HabitsRemoteDataSource _remote;

  @override
  Future<Result<PaginatedList<HabitStatus>>> getHabitsByDate(
    GetHabitsByDateParam param,
  ) {
    return _remote.getHabitsByDate(param);
  }

  @override
  Future<Result<void>> addHabit(HabitStatus habitStatus) {
    // TODO: implement addHabit
    throw UnimplementedError();
  }
}

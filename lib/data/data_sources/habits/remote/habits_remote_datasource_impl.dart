import 'package:habitree/core/network/dio_client.dart';
import 'package:habitree/core/network/safe_call.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/data/data_sources/habits/remote/habits_remote_datasource.dart';
import 'package:habitree/data/models/habit_status/habit_status_dto.dart';
import 'package:habitree/data/models/habit_status/mapper.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';
import 'package:habitree/domain/entities/paginated_list/paginated_list.dart';
import 'package:habitree/domain/usecases/habits/get_habits_status_usecase.dart';
import 'package:injectable/injectable.dart';

const _getHabitsByDatePath = '/rest/v1/rpc/get_user_habits_by_date';

@Injectable(as: HabitsRemoteDataSource)
class HabitsRemoteDataSourceImpl implements HabitsRemoteDataSource {
  const HabitsRemoteDataSourceImpl(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<Result<PaginatedList<HabitStatus>>> getHabitsByDate(
    GetHabitsByDateParam param,
  ) {
    return safeCall(() async {
      final response = await _dioClient.post<dynamic>(
        _getHabitsByDatePath,
        data: {
          'target_date': param.date.toIso8601String(),
          'page_limit': param.limit,
          'page_offset': param.offset,
        },
      );

      final result = PaginatedList.fromJson<HabitStatus>(
        raw: response.data! as Map<String, dynamic>,
        fromJson: (json) => HabitStatusDto.fromJson(json).toEntity(),
      );
      return result;
    });
  }

  @override
  Future<Result<void>> addHabit(HabitStatus habitStatus) {
    // TODO: implement addHabit
    throw UnimplementedError();
  }
}

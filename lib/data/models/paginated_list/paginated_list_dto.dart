import 'package:habitree/domain/entities/paginated_list/paginated_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_list_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedListDto<T> {
  const PaginatedListDto({
    required this.items,
    required this.totalCount,
  });

  factory PaginatedListDto.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedListDtoFromJson(json, fromJsonT);

  final List<T> items;

  @JsonKey(name: 'total_count')
  final int totalCount;

  Map<String, dynamic> toJson(
    Object? Function(T value) toJsonT,
  ) =>
      _$PaginatedListDtoToJson(this, toJsonT);

  PaginatedList<T> toEntity() {
    return PaginatedList<T>(
      items: items,
      totalCount: totalCount,
    );
  }
}

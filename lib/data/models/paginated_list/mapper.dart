import 'package:habitree/data/models/paginated_list/paginated_list_dto.dart';
import 'package:habitree/domain/entities/paginated_list/paginated_list.dart';

extension PaginatedListDtoMapper<TDto, TEntity> on PaginatedListDto<TDto> {
  PaginatedList<TEntity> toEntityList(TEntity Function(TDto) mapper) {
    return PaginatedList(
      items: items.map(mapper).toList(),
      totalCount: totalCount,
    );
  }
}

extension PaginatedListEntityMapper<TDto, TEntity> on PaginatedList<TEntity> {
  PaginatedListDto<TDto> toDtoList(TDto Function(TEntity) mapper) {
    return PaginatedListDto(
      items: items.map(mapper).toList(),
      totalCount: totalCount,
    );
  }
}

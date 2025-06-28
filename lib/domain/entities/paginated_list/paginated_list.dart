class PaginatedList<T> {
  const PaginatedList({
    required this.items,
    required this.totalCount,
  });

  final List<T> items;
  final int totalCount;


  static PaginatedList<T> fromJson<T>({
    required Map<String, dynamic> raw,
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    final items = (raw['items'] as List?)
        ?.map((e) => fromJson(e as Map<String, dynamic>))
        .toList();

    return PaginatedList<T>(
      items: items ?? [],
      totalCount: raw['total_count'] as int,
    );
  }
}

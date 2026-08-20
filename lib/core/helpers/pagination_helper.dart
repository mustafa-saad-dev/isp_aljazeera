class PaginatedResult<T> {
  final List<T> items;
  final int currentPage;
  final int lastPage;
  final int total;

  PaginatedResult({
    required this.items,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  bool get hasNextPage => currentPage < lastPage;

  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson, {
    String listKey = 'data',
  }) {
    final meta = json['meta'] as Map<String, dynamic>?;

    List<T> items = [];
    if (json[listKey] is List) {
      items = (json[listKey] as List)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return PaginatedResult<T>(
      items: items,
      currentPage: meta?['current_page'] ?? 1,
      lastPage: meta?['last_page'] ?? 1,
      total: meta?['total'] ?? items.length,
    );
  }
}



extension MapExtensions on Map {
  /// Returns a new map with all null values removed.
  Map<String, dynamic> dropNull() {
    var map = <String, dynamic>{};
    forEach((key, value) {
      if(value is String && value.isNotEmpty) {
        map[key] = value;
      } else if (value != null) {
        map[key] = value;
      }
    });
    return map;
  }
}

extension IterableExtension<E> on Iterable<E> {
  /// Returns the first element that satisfies the given predicate [test],
  /// or `null` if no elements match.
  E? firstWhereOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension GroupByExtension<T> on Iterable<T> {
  List<Pair> groupBy<K>(K Function(T) keySelector) {
    var map = <K, List<T>>{};

    // Populate the map as before.
    for (var element in this) {
      var key = keySelector(element);
      map.putIfAbsent(key, () => []).add(element);
    }

    // Convert the map to a list of Pairs.
    return map.entries.map((entry) => Pair(entry.key, entry.value)).toList();
  }
}
class Pair<K, V> {
  final K first;
  final List<V> second;

  Pair(this.first, this.second);
}
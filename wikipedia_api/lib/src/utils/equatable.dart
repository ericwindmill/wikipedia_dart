/// Simplified version of the package Equatable
///https://pub.dev/packages/equatable
class Equatable {
  static equals(Object? a, Object? b) => _objectsEquals(a, b);

  static bool _objectsEquals(Object? a, Object? b) {
    if (identical(a, b)) return true;
    if (a is num && b is num) {
      return a == b;
    } else if (a is Set && b is Set) {
      return _setEquals(a, b);
    } else if (a is Iterable && b is Iterable) {
      return iterableEquals(a, b);
    } else if (a is Map && b is Map) {
      return _mapEquals(a, b);
    } else if (a?.runtimeType != b?.runtimeType) {
      return false;
    } else if (a != b) {
      return false;
    }
    return true;
  }

  /// Determines whether two maps are equal.
  static bool _mapEquals(Map<Object?, Object?> a, Map<Object?, Object?> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!_objectsEquals(a[key], b[key])) return false;
    }
    return true;
  }

  /// Determines whether two sets are equal.
  static bool _setEquals(Set<Object?> a, Set<Object?> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (final element in a) {
      if (!b.any((e) => _objectsEquals(element, e))) return false;
    }
    return true;
  }

  static bool iterableEquals(Iterable<Object?> a, Iterable<Object?> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; ++i) {
      if (a.elementAt(i) != b.elementAt(i)) return false;
    }
    return false;
  }
}

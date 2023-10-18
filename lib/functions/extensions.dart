extension ToDouble on dynamic {
  double toDouble() {
    switch (runtimeType) {
      case String:
        return double.parse(this);
      case int:
        return double.parse('$this');
      default:
        return this as double;
    }
  }
}

extension ToListString on dynamic {
  List<String> toListString() {
    if (this is List<dynamic>) {
      return map((e) => e.toString()).toList();
    } else {
      throw Exception("Expected a List<Dynamic>, got $runtimeType");
    }
  }
}

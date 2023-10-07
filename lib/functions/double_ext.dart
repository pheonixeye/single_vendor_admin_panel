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

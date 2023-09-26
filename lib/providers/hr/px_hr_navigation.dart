import 'package:flutter/material.dart';

class PxHRnavigation extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void navigate(int to) {
    _index = to;
    notifyListeners();
  }
}

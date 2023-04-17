import 'package:flutter/material.dart';

class BottomNavController with ChangeNotifier {
  int currentindex = 0;
  void bottomSwitch(index) {
    currentindex = index;
    notifyListeners();
  }
}

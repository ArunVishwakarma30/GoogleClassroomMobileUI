import 'package:flutter/cupertino.dart';

class NavbarProvider extends ChangeNotifier{

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}
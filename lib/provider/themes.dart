import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  ThemeData get theme => _themeData;

  set theme(ThemeData theme) {
    this._themeData = theme;
    notifyListeners();
  }
}

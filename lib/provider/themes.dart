import 'package:flutter/material.dart';

enum ThemeType {
  light,
  dark,
}

class ThemeChanger with ChangeNotifier {
  ThemeData _lightThemeData;
  ThemeData _darkThemeData;

  ThemeType _currTheme;

  ThemeChanger() {
    _currTheme = ThemeType.light;
    _lightThemeData = ThemeData(
      primarySwatch: Colors.blue,
      canvasColor: Color(0xFFbbd6ff),
      accentColor: Colors.deepPurple,
      accentColorBrightness: Brightness.dark,
      fontFamily: 'Righteous-Regular',
      textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            fontSize: 36,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
              fontSize: 48,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.black),
          headline5: TextStyle(
              fontSize: 150,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.black),
          headline6: TextStyle(fontSize: 150, color: Colors.white),
          bodyText1: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          bodyText2: TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5)),
    );
    _darkThemeData = ThemeData(
      primarySwatch: Colors.indigo,
      canvasColor: Color(0xFF00183f),
      accentColor: Colors.deepPurple,
      accentColorBrightness: Brightness.dark,
      fontFamily: 'Righteous-Regular',
      textTheme: ThemeData.dark().textTheme.copyWith(
          headline1: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
              fontSize: 48,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.black),
          headline5: TextStyle(
              fontSize: 150,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.black),
          headline6: TextStyle(fontSize: 150, color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.5,
              color: Colors.white)),
    );
  }

  ThemeData get themeData {
    if (_currTheme == ThemeType.dark) {
      return _darkThemeData;
    }
    return _lightThemeData;
  }

  ThemeType get currTheme {
    return _currTheme;
  }

  setTheme(ThemeType theme) {
    this._currTheme = theme;
    notifyListeners();
  }
}

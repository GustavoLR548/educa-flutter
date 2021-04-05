import 'package:educa/provider/exercicios.dart';
import 'package:educa/screens/Exercicio/Exercicio.dart';
import 'package:educa/screens/Exercicio/Tutorial.dart';
import 'package:provider/provider.dart';
import 'package:educa/screens/AuthScreen.dart';
import 'package:educa/screens/Homepage/HomepageTabController.dart';
import 'package:educa/screens/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) => ChangeNotifierProvider.value(
        value: Exercicios(),
        child: MaterialApp(
          title: 'Educa',
          theme: ThemeData(
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
                  bodyText1:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  bodyText2: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5)),
              buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.blueAccent,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
          home: snapshot.connectionState != ConnectionState.done
              ? SplashScreen()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return HomepageTabController();
                    }
                    return AuthScreen();
                  }),
          routes: {
            Tutorial.routeName: (ctx) => Tutorial(),
            ExercicioScreen.routeName: (ctx) => ExercicioScreen(),
          },
        ),
      ),
    );
  }
}

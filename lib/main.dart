import 'package:educa/provider/auth.dart';
import 'package:educa/provider/exercicios.dart';
import 'package:educa/screens/Exercicio/Exercicio.dart';
import 'package:educa/screens/Exercicio/Tutorial.dart';
import 'package:provider/provider.dart';
import 'package:educa/screens/AuthScreen.dart';
import 'package:educa/screens/Homepage/HomepageTabController.dart';
import 'package:educa/screens/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) =>
          snapshot.connectionState != ConnectionState.done
              ? SplashScreen()
              : MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: Auth()),
                    ChangeNotifierProvider.value(
                      value: Exercicios(),
                    ),
                  ],
                  child: Consumer<Auth>(
                    builder: (ctx, authData, _) => MaterialApp(
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
                              headline5: TextStyle(
                                  fontSize: 150,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color = Colors.black),
                              headline6:
                                  TextStyle(fontSize: 150, color: Colors.white),
                              bodyText1: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                              bodyText2: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0.5)),
                          buttonTheme: ButtonTheme.of(context).copyWith(
                              buttonColor: Colors.blueAccent,
                              textTheme: ButtonTextTheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      home: StreamBuilder(
                          stream: authData.tryAutoLogin(),
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
                ),
    );
  }
}

import 'package:educa/provider/auth.dart';
import 'package:educa/provider/exercicios.dart';
import 'package:educa/provider/themes.dart';
import 'package:educa/screens/Configuration.dart';
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
      builder: (context, snapshot) {
        var consumer = Consumer<Auth>(
          builder: (ctx, authData, _) => MyMaterialApp(authData: authData),
        );
        return snapshot.connectionState != ConnectionState.done
            ? SplashScreen()
            : MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(value: Auth()),
                  ChangeNotifierProvider.value(
                    value: Exercicios(),
                  ),
                  ChangeNotifierProvider.value(value: ThemeChanger())
                ],
                child: consumer,
              );
      },
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  final Auth authData;

  const MyMaterialApp({Key key, @required this.authData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      title: 'Educa',
      theme: theme.themeData,
      home: StreamBuilder(
          stream: authData.tryAutoLogin(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return HomepageTabController();
            }
            return AuthScreen();
          }),
      routes: {
        HomepageTabController.routeName: (ctx) => HomepageTabController(),
        Tutorial.routeName: (ctx) => Tutorial(),
        Configuration.routeName: (ctx) => Configuration(),
        ExercicioScreen.routeName: (ctx) => ExercicioScreen(),
      },
    );
  }
}

import 'package:educa/models/exercicio.dart';
import 'package:educa/provider/auth.dart';
import 'package:educa/widgets/exercicio/MyCarouselPlayer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExercicioScreen extends StatefulWidget {
  static const routeName = '/tela-exercicio';

  @override
  _ExercicioScreenState createState() => _ExercicioScreenState();
}

class _ExercicioScreenState extends State<ExercicioScreen> {
  bool _hasInitiated = true;
  bool _finishedExercise = false;
  Exercicio exercicioAtual;

  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasInitiated)
      exercicioAtual = ModalRoute.of(context).settings.arguments as Exercicio;

    _hasInitiated = false;
  }

  @override
  Widget build(BuildContext context) {
    print(_finishedExercise);
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercício'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            if (!exercicioAtual.exercicio['carouselPlayer'].isEmpty)
              MyCarouselPlayer(
                exercicioAtual.exercicio['carouselPlayer']['top'],
                exercicioAtual.exercicio['carouselPlayer']['bottom'],
                onFinish: () {
                  setState(() {
                    _finishedExercise = true;
                  });
                },
              ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: !_finishedExercise
                        ? null
                        : () async {
                            Provider.of<Auth>(context, listen: false)
                                .updateQuestion(exercicioAtual.id);
                            Navigator.of(context).pop();
                          },
                    child: Text('Finalizar teste')))
          ]),
        ),
      ),
    );
  }
}

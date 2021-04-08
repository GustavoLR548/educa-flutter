import 'package:educa/models/exercicio.dart';
import 'package:educa/widgets/exercicio/MyCarouselPlayer.dart';
import 'package:flutter/material.dart';

class ExercicioScreen extends StatelessWidget {
  static const routeName = '/tela-exercicio';

  @override
  Widget build(BuildContext context) {
    final exercicioAtual =
        ModalRoute.of(context).settings.arguments as Exercicio;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exercício'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!exercicioAtual.exercicio['carouselPlayer'].isEmpty)
                MyCarouselPlayer(
                    exercicioAtual.exercicio['carouselPlayer']['top'],
                    exercicioAtual.exercicio['carouselPlayer']['bottom']),
              Center(
                  child: ElevatedButton(
                      onPressed: null, child: Text('Finalizar teste')))
            ]),
      ),
    );
  }
}

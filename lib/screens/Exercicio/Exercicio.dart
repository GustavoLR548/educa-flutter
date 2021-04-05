import 'package:educa/models/exercicio.dart';
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
          child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          if (!exercicioAtual.tutorial['texto'].isEmpty)
            Text(exercicioAtual.tutorial['texto']),
          Center(
              child: ElevatedButton(
                  onPressed: null, child: Text('Finalizar teste')))
        ]),
      )),
    );
  }
}

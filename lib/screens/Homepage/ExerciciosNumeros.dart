import 'package:educa/provider/exercicios.dart';
import 'package:educa/screens/Exercicio/Tutorial.dart';
import 'package:educa/widgets/exercicio_card/exercicio_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciciosNumeros extends StatelessWidget {
  final Map<String, dynamic> exercises;

  ExerciciosNumeros(this.exercises);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<Exercicios>(builder: (context, allExercicios, _) {
        final matematica = allExercicios.exerciciosMatematica;
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: matematica.length,
            itemBuilder: (context, index) {
              bool terminado;
              if (exercises == null)
                terminado = false;
              else
                terminado = exercises[matematica[index].id] == true;
              return ExercicioCard(
                  imageUrl: matematica[index].capaUrl,
                  title: matematica[index].titulo,
                  dificuldade: matematica[index].dificuldadeString,
                  tempoEstimado: matematica[index].tempoEstimado,
                  terminado: terminado,
                  onTap: () {
                    Navigator.of(context).pushNamed(Tutorial.routeName,
                        arguments: matematica[index]);
                  });
            });
      }),
    );
  }
}

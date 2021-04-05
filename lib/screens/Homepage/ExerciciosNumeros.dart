import 'package:educa/provider/exercicios.dart';
import 'package:educa/screens/Exercicio/Tutorial.dart';
import 'package:educa/widgets/exercicio_card/exercicio_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciciosNumeros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<Exercicios>(builder: (context, allExercicios, _) {
        final matematica = allExercicios.exerciciosMatematica;
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: matematica.length,
            itemBuilder: (context, index) => ExercicioCard(
                  imageUrl: matematica[index].capaUrl,
                  title: matematica[index].titulo,
                  dificuldade: matematica[index].dificuldadeString,
                  tempoEstimado: matematica[index].tempoEstimado,
                  onTap: () {
                    Navigator.of(context).pushNamed(Tutorial.routeName,
                        arguments: matematica[index]);
                  },
                ));
      }),
    );
  }
}

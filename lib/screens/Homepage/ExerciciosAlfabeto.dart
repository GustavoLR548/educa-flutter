import 'package:educa/provider/exercicios.dart';
import 'package:educa/screens/Exercicio/Tutorial.dart';
import 'package:educa/widgets/exercicio_card/exercicio_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciciosAlfabeto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<Exercicios>(builder: (context, allExercicios, _) {
        final alfabeto = allExercicios.exercicioAlfabeto;
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: alfabeto.length,
            itemBuilder: (context, index) => ExercicioCard(
                  imageUrl: alfabeto[index].capaUrl,
                  title: alfabeto[index].titulo,
                  dificuldade: alfabeto[index].dificuldadeString,
                  tempoEstimado: alfabeto[index].tempoEstimado,
                  onTap: () {
                    Navigator.of(context).pushNamed(Tutorial.routeName,
                        arguments: alfabeto[index]);
                  },
                ));
      }),
    );
  }
}

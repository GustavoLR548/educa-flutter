import 'package:educa/widgets/exercicio_card/information_box.dart';
import 'package:flutter/material.dart';

class ExercicioCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String dificuldade;

  final int tempoEstimado;
  final Function onTap;

  final bool terminado;

  const ExercicioCard(
      {this.imageUrl,
      this.terminado = false,
      this.title,
      this.dificuldade,
      this.tempoEstimado,
      @required this.onTap});

  Widget build(BuildContext context) {
    final foodImage = FadeInImage(
        height: 250,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: AssetImage('assets/images/placeholder.jpg'),
        image: NetworkImage(
          imageUrl,
        ));

    return InkWell(
        onTap: onTap,
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15)),
                    child: foodImage,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 80,
                    child: Card(
                        elevation: 8,
                        child: Text(
                          this.title,
                          style: Theme.of(context).textTheme.headline2,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  )
                ]),
                Container(
                    color: !terminado ? Color(0xFFff5454) : Color(0xFF75e149),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InformationBox(
                              information: '${this.tempoEstimado} min',
                              icon: Icons.schedule,
                              width: 6),
                          InformationBox(
                              information: dificuldade,
                              icon: Icons.assessment_outlined,
                              width: 6),
                          InformationBox(
                              information: '',
                              icon: !terminado
                                  ? Icons.assignment_turned_in_outlined
                                  : Icons.assignment_turned_in,
                              width: 6),
                        ])),
              ],
            )));
  }
}

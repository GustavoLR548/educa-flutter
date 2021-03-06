import 'package:educa/components/MusicPlayer.dart';
import 'package:educa/models/exercicio.dart';
import 'package:educa/screens/Exercicio/Exercicio.dart';
import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  static const routeName = '/tela-tutorial';
  @override
  Widget build(BuildContext context) {
    final exercicioAtual =
        ModalRoute.of(context).settings.arguments as Exercicio;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(7))),
              child: MusicPlayer(
                  title: 'Explicação',
                  initialMusicUrl: exercicioAtual.falaProfessorUrl)),
          Text(
            exercicioAtual.titulo,
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 25,
          ),
          if (!exercicioAtual.tutorial['texto'].isEmpty)
            Text(exercicioAtual.tutorial['texto']),
          const SizedBox(
            height: 25,
          ),
          if (Uri.parse(exercicioAtual.tutorial['imagem']).isAbsolute)
            FadeInImage(
                height: 250,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: AssetImage('assets/images/placeholder.jpg'),
                image: NetworkImage(
                  exercicioAtual.tutorial['imagem'],
                )),
          const SizedBox(
            height: 25,
          ),
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        ExercicioScreen.routeName,
                        arguments: exercicioAtual);
                  },
                  child: Text('Iniciar teste'))),
        ]),
      ),
    );
  }
}

import 'package:educa/models/exercicio.dart';
import 'package:flutter/material.dart';

class Exercicios with ChangeNotifier {
  List<Exercicio> _items = [
    Exercicio(
      id: '1',
      titulo: 'Início: Alfabeto',
      professor: 'Gustavo LR',
      capaUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Green_flag_waving.svg/1200px-Green_flag_waving.svg.png',
      dificuldade: Dificuldade.facil,
      falaProfessorUrl:
          'https://raw.githubusercontent.com/15Horas/erick-app-songs/main/yt1s.com%20-%20Legi%C3%A3o%20Urbana%20Faroeste%20caboclo.mp3',
      tipoDeExercicio: TipoDeExercicio.alfabeto,
      tutorial: {
        'texto':
            'Seja bem vindo ao primeiro exercicio do alfabeto, não há necessidade para se apressar, vamos passo-a-passo , e você mesmo irá enxergar o quão simples é',
        'imagem':
            'https://cdn5.vectorstock.com/i/1000x1000/88/39/funny-colorful-alphabet-vector-6558839.jpg'
      },
      tempoEstimado: 10,
    ),
    Exercicio(
      id: '2',
      titulo: 'Início: Matematica',
      professor: 'Gustavo LR',
      capaUrl: 'https://i.ytimg.com/vi/0sEUdmtyJ3U/maxresdefault.jpg',
      dificuldade: Dificuldade.facil,
      falaProfessorUrl:
          'https://raw.githubusercontent.com/15Horas/erick-app-songs/main/yt1s.com%20-%20Legi%C3%A3o%20Urbana%20Faroeste%20caboclo.mp3',
      tipoDeExercicio: TipoDeExercicio.matematica,
      tutorial: {
        'texto':
            'Seja bem vindo ao primeiro exercicio do matemática, não há necessidade para se apressar, vamos passo-a-passo , e você mesmo irá enxergar o quão simples é',
        'imagem': 'https://i.imgur.com/Pz5tLyT.png'
      },
      tempoEstimado: 10,
    ),
  ];

  List<Exercicio> get exercicioAlfabeto {
    List<Exercicio> result = [];
    _items.forEach((element) {
      if (element.tipoDeExercicio == TipoDeExercicio.alfabeto)
        result.add(element);
    });
    return result;
  }

  List<Exercicio> get exerciciosMatematica {
    List<Exercicio> result = [];
    _items.forEach((element) {
      if (element.tipoDeExercicio == TipoDeExercicio.matematica)
        result.add(element);
    });
    return result;
  }

  int get size {
    return _items.length;
  }

  Exercicio find(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}

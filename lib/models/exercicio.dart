import 'package:flutter/material.dart';

enum Dificuldade {
  facil,
  medio,
  dificil,
}

enum TipoDeExercicio {
  alfabeto,
  matematica,
}

class Exercicio with ChangeNotifier {
  final String id;
  String titulo;
  String professor;
  String capaUrl;
  Dificuldade dificuldade;
  int tempoEstimado;
  TipoDeExercicio tipoDeExercicio;
  String falaProfessorUrl;
  Map<String, dynamic> tutorial;
  Map<String, dynamic> exercicio;

  Exercicio(
      {this.id = '337',
      this.professor = 'N/A',
      @required this.falaProfessorUrl,
      this.titulo = 'Exercicio',
      this.capaUrl = '',
      this.dificuldade = Dificuldade.facil,
      this.tempoEstimado = 10,
      this.tipoDeExercicio = TipoDeExercicio.alfabeto,
      this.tutorial = const {'texto': '', 'imagem': ''},
      this.exercicio = const {'texto': '', 'imagem': ''}});

  String get dificuldadeString {
    String resp;
    switch (dificuldade) {
      case Dificuldade.facil:
        resp = 'Fácil';
        break;
      case Dificuldade.medio:
        resp = 'Médio';
        break;
      case Dificuldade.dificil:
        resp = 'Difícil';
        break;
      default:
        resp = 'N/A';
        break;
    }
    return resp;
  }
}

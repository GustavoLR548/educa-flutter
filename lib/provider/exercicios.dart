import 'package:educa/models/exercicio.dart';
import 'package:flutter/material.dart';

class Exercicios with ChangeNotifier {
  List<Exercicio> _items = [
    Exercicio(
      id: 'alph1',
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
        'imagem': 'https://i.imgur.com/MXzF7yV.png'
      },
      exercicio: {
        'carouselPlayer': {
          'top': [
            'A',
            'B',
            'C',
            'D',
            'E',
            'F',
            'G',
            'H',
            'I',
            'J',
            'K',
            'L',
            'M',
            'N',
            'O',
            'P',
            'Q',
            'R',
            'S',
            'T',
            'U',
            'V',
            'W',
            'X',
            'Y',
            'Z'
          ],
          'bottom': [
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/A.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/B.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/C.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/D.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/E.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/F.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/G.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/H.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/I.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/J.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/K.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/L.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/M.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/N.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/O.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/P.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/Q.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/R.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/S.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/T.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/U.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/V.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/W.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/X.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/Y.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/alf/Z.mp3',
          ]
        }
      },
      tempoEstimado: 10,
    ),
    Exercicio(
      id: 'math2',
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
      exercicio: {
        'carouselPlayer': {
          'top': [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            '10',
            '11',
            '12',
            '13',
            '14',
            '15',
            '16',
            '17',
            '18',
            '19',
            '20',
          ],
          'bottom': [
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/1.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/2.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/3.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/4.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/5.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/6.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/7.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/8.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/9.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/10.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/11.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/12.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/13.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/14.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/15.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/16.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/17.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/18.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/19.mp3',
            'https://media.githubusercontent.com/media/MysteRys337/educa-flutter/main/assets/mat/20.mp3',
          ]
        }
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

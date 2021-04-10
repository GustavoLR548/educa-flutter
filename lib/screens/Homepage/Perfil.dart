import 'package:educa/provider/themes.dart';
import 'package:educa/widgets/misc/circle_fade_in_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Perfil extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String email;

  final int pontuacaoAlph;
  final int pontuacaoMath;

  const Perfil(this.name, this.email, this.imageUrl, this.pontuacaoAlph,
      this.pontuacaoMath);

  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeChanger>(context);
    final themeColor = themeData.currTheme == ThemeType.light
        ? Colors.blue[200]
        : Colors.indigoAccent;

    return Column(
      children: [
        Card(
          color: themeColor,
          elevation: 8,
          margin: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 5, bottom: 15),
                child: CircleFadeInAvatar(imageUrl),
              ),
              FittedBox(
                fit: BoxFit.cover,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      email,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Text(pontuacaoAlph.toString()),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(
                          Icons.mode_outlined,
                          color: Colors.yellow,
                        ),
                        Text(pontuacaoMath.toString()),
                      ],
                    ),
                    Text(
                      'Total: ' + (pontuacaoAlph + pontuacaoMath).toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

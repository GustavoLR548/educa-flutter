import 'package:carousel_slider/carousel_slider.dart';
import 'package:educa/components/MusicPlayer.dart';
import 'package:flutter/material.dart';

class MyCarouselPlayer extends StatefulWidget {
  final List<String> carouselContent;
  final List<String> audioList;

  const MyCarouselPlayer(this.carouselContent, this.audioList);

  @override
  _MyCarouselPlayerState createState() => _MyCarouselPlayerState();
}

class _MyCarouselPlayerState extends State<MyCarouselPlayer> {
  int currMusicIndex = 0;
  List<Widget> slider = [];

  static const availableColors = [
    Colors.red,
    Colors.amber,
    Colors.purple,
    Colors.blue,
    Colors.amber,
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.indigo
  ];
  @override
  Widget build(BuildContext context) {
    List<Widget> slider = [];

    for (int i = 0; i < widget.audioList.length; i++) {
      slider.add(Center(
          child: Card(
        elevation: 8,
        child: Container(
          height: 350,
          width: 250,
          color: availableColors[currMusicIndex % availableColors.length],
          child: Column(
            children: [
              Stack(
                children: [
                  Text(
                    widget.carouselContent[i],
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    widget.carouselContent[i],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
        ),
      )));
    }
    return Padding(
      padding: const EdgeInsets.only(top: 45),
      child: Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currMusicIndex = index;
                    });
                  }),
              items: slider),
          Container(
              width: 250,
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(7))),
              child: MusicPlayer(musicUrl: widget.audioList[currMusicIndex])),
        ],
      ),
    );
  }
}

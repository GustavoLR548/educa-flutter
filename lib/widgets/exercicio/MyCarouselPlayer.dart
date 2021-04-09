import 'package:carousel_slider/carousel_slider.dart';
import 'package:educa/components/MusicPlayer.dart';
import 'package:flutter/material.dart';

class MyCarouselPlayer extends StatefulWidget {
  final List<String> carouselContent;
  final List<String> audioList;

  final Function onFinish;

  const MyCarouselPlayer(this.carouselContent, this.audioList,
      {@required this.onFinish});

  @override
  _MyCarouselPlayerState createState() => _MyCarouselPlayerState();
}

class _MyCarouselPlayerState extends State<MyCarouselPlayer> {
  int currMusicIndex = 0;
  List<Widget> slider = [];
  List<int> alreadyVisitedPages = [];
  bool _hasInitiated = true;
  String currentAudio = '';

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

  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_hasInitiated) {
      currentAudio = widget.audioList[currMusicIndex];
      alreadyVisitedPages.add(0);
      for (int i = 0; i < widget.audioList.length; i++) {
        slider.add(Center(
            child: Card(
          elevation: 8,
          child: Container(
            height: 350,
            width: 250,
            color: availableColors[i % availableColors.length],
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
    }
    _hasInitiated = false;
  }

  @override
  Widget build(BuildContext context) {
    print(currentAudio);
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
                      currentAudio = widget.audioList[currMusicIndex];
                      if (!alreadyVisitedPages.contains(index))
                        alreadyVisitedPages.add(index);
                    });

                    if (_finishedExercise()) widget.onFinish();
                  }),
              items: slider),
          const SizedBox(
            height: 20,
          ),
          Container(
              width: 250,
              decoration: BoxDecoration(
                  color:
                      availableColors[currMusicIndex % availableColors.length],
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(7))),
              child: MusicPlayer(
                initialMusicUrl: currentAudio,
                autoplay: false,
                hideSlider: true,
              )),
        ],
      ),
    );
  }

  bool _finishedExercise() {
    return (alreadyVisitedPages.length == widget.audioList.length);
  }
}

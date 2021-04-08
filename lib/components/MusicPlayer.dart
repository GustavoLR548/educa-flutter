import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  final String musicUrl;
  final String title;

  const MusicPlayer({Key key, this.title = '', @required this.musicUrl})
      : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;
  bool isActive = false;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool seekDone;

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.onDurationChanged.listen((d) => setState(() {
          _duration = d;
        }));

    advancedPlayer.onAudioPositionChanged.listen((p) => setState(() {
          _position = p;
        }));
    this.advancedPlayer.setUrl(widget.musicUrl);
    this.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
    this.advancedPlayer.play(widget.musicUrl, isLocal: false);
    this.isActive = true;
  }

  void deactivate() {
    this.advancedPlayer.stop();
    super.deactivate();
  }

  void dispose() {
    advancedPlayer.dispose();
    super.dispose();
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    advancedPlayer.seek(newDuration);
  }

  void handlePausePlay() {
    if (this.isActive) {
      this.advancedPlayer.pause();
    } else {
      this.advancedPlayer.resume();
    }
    setState(() {
      this.isActive = !this.isActive;
    });
  }

  void handleStop() {
    this.advancedPlayer.stop();
    setState(() {
      this.isActive = false;
    });
  }

  void handleSlideChange(double value) {
    setState(() {
      seekToSecond(value.toInt());
      value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            if (!widget.title.isEmpty)
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            TextButton(
              onPressed: () => handlePausePlay(),
              child: Icon(
                this.isActive ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () => handleStop(),
              child: const Icon(Icons.stop, color: Colors.white),
            ),
          ]),
          Slider(
              value: _position.inSeconds.toDouble(),
              min: 0.0,
              max: _duration.inSeconds.toDouble(),
              activeColor: Colors.white,
              inactiveColor: Colors.white10,
              onChanged: (double value) => handleSlideChange(value))
        ],
      ),
    );
  }
}

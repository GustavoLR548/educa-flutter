import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  final String initialMusicUrl;
  final String title;
  final bool autoplay;
  final bool hideSlider;

  const MusicPlayer({
    Key key,
    this.title = '',
    @required this.initialMusicUrl,
    this.autoplay = true,
    this.hideSlider = false,
  }) : super(key: key);

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
    super.initState();
    initPlayer();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
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
  }

  void deactivate() {
    super.deactivate();
    this.advancedPlayer.stop();
  }

  void dispose() {
    super.dispose();
    advancedPlayer.dispose();
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
    setState(() {
      this.advancedPlayer.setUrl(widget.initialMusicUrl);
      this.advancedPlayer.setReleaseMode(ReleaseMode.STOP);
      this.advancedPlayer.play(widget.initialMusicUrl, isLocal: false);
      this.isActive = widget.autoplay;
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            if (widget.title.isNotEmpty)
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
            if (!widget.hideSlider)
              TextButton(
                onPressed: () => handleStop(),
                child: const Icon(Icons.stop, color: Colors.white),
              ),
          ]),
          if (!widget.hideSlider)
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

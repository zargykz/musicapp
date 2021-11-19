import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  const AudioFile({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final String path =
      "https://d2c3ct5w4v6137.cloudfront.net/youtube_FNCOe01yZkU/251/Le%C3%B3n%20Larregui%20-%20Souvenir%20(Audio)_160k.mp3";
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color coloreo = Colors.black;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    this.widget.advancedPlayer.setUrl(path);
    this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  Widget btnStart() {
    //isPlaying=bool;
    return IconButton(
        padding: const EdgeInsets.only(bottom: 10),
        icon: isPlaying == false
            ? Icon(_icons[0], size: 50, color: Colors.blueGrey)
            : Icon(_icons[1], size: 48, color: Colors.blue),
        onPressed: () {
          if (isPlaying == false) {
            this.widget.advancedPlayer.play(path);
            setState(() {
              isPlaying = true;
            });
          } else if (isPlaying == true) {
            this.widget.advancedPlayer.pause();
            setState(() {
              isPlaying = false;
            });
          }
        });
  }

  Widget btnFast() {
    return IconButton(
      icon: Icon(
        Icons.fast_forward_rounded,
        size: 35,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: Icon(
        Icons.slow_motion_video_rounded,
        size: 35,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: Icon(
        Icons.settings_backup_restore,
        size: 25,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
        icon: Icon(
          Icons.loop_rounded,
          size: 25,
          color: coloreo,
        ),
        onPressed: () {
          if (isRepeat == false) {
            this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
            setState(() {
              isRepeat = true;
              coloreo = Colors.blue;
            });
          } else if (isRepeat == true) {
            this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
            coloreo = Colors.black;
            isRepeat = false;
          }
        });
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.blue[200],
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Container(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [btnRepeat(), btnSlow(), btnStart(), btnFast(), btnLoop()]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _position.toString().split(".")[0],
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    _duration.toString().split(".")[0],
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              )),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}

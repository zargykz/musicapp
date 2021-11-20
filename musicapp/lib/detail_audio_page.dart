// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;
import 'package:audioplayers/audioplayers.dart';

import 'audio_file.dart';

class DetailAudioPage extends StatefulWidget {
  final inicialData;
  final int index;
  const DetailAudioPage({Key? key, this.inicialData, required this.index})
      : super(key: key);
  @override
  _DetailAudioPageState createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  AudioPlayer advancedPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBlishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                color: AppColors.audioBlueBackground,
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                leading: IconButton(
                  // ignore: prefer_const_constructors
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    advancedPlayer.stop();
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  )
                ],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              )),
          Positioned(
              height: screenHeight * 0.36,
              top: screenHeight * 0.2,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      this.widget.inicialData[this.widget.index]["title"],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Avenir",
                      ),
                    ),
                    Text(
                      this.widget.inicialData[this.widget.index]["text"],
                      style: TextStyle(fontSize: 15),
                    ),
                    AudioFile(
                        advancedPlayer: advancedPlayer,
                        audioPath: this.widget.inicialData[this.widget.index]
                            ["audio"]),
                  ],
                ),
              )),
          Positioned(
              top: screenHeight * 0.1,
              left: (screenWidth - 130) / 2,
              right: (screenWidth - 130) / 2,
              height: screenHeight * 0.19,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.audioGreyBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    image: DecorationImage(
                      image: AssetImage(
                        this.widget.inicialData[this.widget.index]["img"],
                      ),
                      fit: BoxFit.fill,
                    ),
                  )),
                ),
              ))
        ],
      ),
    );
  }
}

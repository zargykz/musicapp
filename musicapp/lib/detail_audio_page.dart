// ignore_for_file: unnecessary_this

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/button_widget.dart';
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
              )),
          Positioned(
              height: screenHeight * 0.31,
              top: screenHeight * 0.75,
              left: 160,
              right: -50,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        showCustomDialog(context);
                      },
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Text(
                              'Letra',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.library_music,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Positioned(
              height: screenHeight * 0.31,
              top: screenHeight * 0.75,
              left: -10,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Bounce(
                    child: Row(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {},
                          color: AppColors.menu1Color,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Text(
                                  'Comprar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.shop,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    infinite: true,
                    duration: Duration(seconds: 3),
                    delay: Duration(seconds: 4)),
              )),
          Positioned(
              height: screenHeight * 0.20,
              top: screenHeight * 0.60,
              left: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.sliverBackground,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber, width: 2),
                      image: const DecorationImage(
                          image: NetworkImage(
                        "https://filosofiafundamental.com/wp-content/uploads/2021/05/WAVE.gif",
                      ))))),
        ],
      ),
    );
  }

  void showCustomDialog(BuildContext context) => showDialog(
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                SizedBox(height: 12),
                Text(
                  this.widget.inicialData[this.widget.index]["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  this.widget.inicialData[this.widget.index]["letra"],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  child: Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
        ),
        context: context,
        barrierDismissible: false,
      );
}

showCustomDialog(BuildContext context) {}

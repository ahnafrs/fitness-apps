import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:day35/home_page.dart';
import 'package:day35/model.dart';
import 'package:day35/widget.dart';
import 'package:flutter/material.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key? key, this.exercise, this.second}) : super(key: key);

  final Exercise? exercise;
  int? second;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool isPlaying = false;
  bool isComplete = false;
  int startSound = 0;
  late Timer timer;
  String musicPath = "assets/music.mp3";

  playAudio() async {
    // await audioCache.load(musicPath);
    // await audioPlayer.play(AssetSource(musicPath));
  }

  @override
  void initState() {
    // TODO: implement initState
    // playAudio();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var x = widget.second! - 1;

      print("${x}");

      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          //isPlaying = true;
          playAudio();
          showToast("WorkOut Succesfull");
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Color(0x44000008),
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Do your Best",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            CachedNetworkImage(
              width: double.infinity,
              imageUrl: "${widget.exercise!.gif}",
              fit: BoxFit.cover,
              placeholder: (context, url) => spinkit,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 50,
              child: Text(
                "$startSound",
                style: TextStyle(fontSize: 20, color: Colors.amberAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}

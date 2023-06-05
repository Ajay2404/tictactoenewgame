import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoenewgame/config.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool music = false;
  bool audio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCommon.bgColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            "Settings",
            style: TextStyle(
                color: colorCommon.yColor, fontFamily: "family", fontSize: 40),
          ),
        ),
        SizedBox(height: 80),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              setState(
                () {
                  audio = !audio;
                },
              );
            },
            child: Container(
                padding: EdgeInsets.only(left: 80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorCommon.yColor,
                ),
                alignment: Alignment.center,
                width: 300,
                height: 90,
                child: Row(
                  children: [
                    Text(
                      "Audio",
                      style: TextStyle(
                          color: colorCommon.bgColor,
                          fontFamily: "family",
                          fontSize: 30),
                    ).paddingOnly(right: 40),
                    Icon(
                      size: 40,
                      audio
                          ? Icons.volume_up_rounded
                          : Icons.volume_off_rounded,
                      color: colorCommon.bgColor,
                    )
                  ],
                )),
          ),
        ]),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () {
              setState(
                () {
                  music = !music;
                },
              );
            },
            child: Container(
                padding: EdgeInsets.only(left: 80),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorCommon.yColor,
                ),
                width: 300,
                height: 90,
                child: Row(
                  children: [
                    Text(
                      "Music",
                      style: TextStyle(
                          color: colorCommon.bgColor,
                          fontFamily: "family",
                          fontSize: 30),
                    ).paddingOnly(right: 40),
                    Icon(
                      size: 40,
                      music
                          ? Icons.music_note_rounded
                          : Icons.music_off_rounded,
                      color: colorCommon.bgColor,
                    )
                  ],
                )),
          ),
        ]),
      ]),
    );
  }
}

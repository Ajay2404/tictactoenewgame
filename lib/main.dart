import 'dart:async';
import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tictactoenewgame/playerOption.dart';
import 'package:tictactoenewgame/settingPage.dart';
import 'package:tictactoenewgame/splash_screen.dart';

import 'config.dart';
import 'howToPlay.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  String playerName = '';

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    animation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCommon.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 130,
          ),
          Center(
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  '''Tic Tac Toe''',
                  textStyle: const TextStyle(
                    fontFamily: "family",
                    fontSize: 50.0,
                    color: Color(0xffffca28),
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 10,
              pause: const Duration(milliseconds: 100),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const PlayerOption();
              },
            )),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorCommon.yColor,
                ),
                alignment: Alignment.center,
                width: 300,
                height: 90,
                child: Text(
                  "Start Game",
                  style: TextStyle(
                      color: colorCommon.bgColor,
                      fontFamily: "family",
                      fontSize: 40),
                )).paddingOnly(top: 110),
          ),//start game
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  Timer(const Duration(seconds: 30), () {});
                  return AlertDialog(
                      backgroundColor: colorCommon.yColor,
                      content: Text(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: colorCommon.bgColor,
                              fontFamily: "family",
                              fontSize: 30),
                          "We apologize, but the advanced level is currently unavailable for your access."));
                },
              );
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorCommon.yColor,
                ),
                alignment: Alignment.center,
                width: 300,
                height: 90,
                child: Text(
                  "Advanced",
                  style: TextStyle(
                      color: colorCommon.bgColor,
                      fontFamily: "family",
                      fontSize: 40),
                )).paddingSymmetric(vertical: 20),
          ),//advance level
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const HowToPlay();
                },
              ));
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colorCommon.yColor,
                ),
                alignment: Alignment.center,
                width: 300,
                height: 90,
                child: Text(
                  "How To Play",
                  style: TextStyle(
                      color: colorCommon.bgColor,
                      fontFamily: "family",
                      fontSize: 40),
                )),
          ),//how to play
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const SettingPage();
                },
              ));
            },
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.rotate(
                    angle: animation.value,
                    child:
                        SvgPicture.asset("image/svg/settings.svg", height: 60)
                            .paddingAll(20));
              },
            ),
          ),
        ],
      ),
    );
  }
}

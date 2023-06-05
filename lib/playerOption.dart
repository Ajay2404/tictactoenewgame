import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoenewgame/optionSelect.dart';
import 'package:tictactoenewgame/playWithFriends.dart';

import 'config.dart';

class PlayerOption extends StatefulWidget {
  const PlayerOption({Key? key}) : super(key: key);

  @override
  State<PlayerOption> createState() => _PlayerOptionState();
}

class _PlayerOptionState extends State<PlayerOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCommon.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Text(
            "Play With",
            style: TextStyle(
                color: colorCommon.yColor, fontFamily: "family", fontSize: 40),
          ).paddingOnly(top: 100, bottom: 20),
          chooseButton(context: context, title: "Ai"),
          chooseButton(context: context, title: "FRIENDS"),
          // GestureDetector(
          //   onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (context) {
          //       return const OptionSelect();
          //     },
          //   )),
          //   child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: colorCommon.yColor,
          //       ),
          //       alignment: Alignment.center,
          //       width: 300,
          //       height: 90,
          //       child: Text(
          //         "AI",
          //         style: TextStyle(
          //             color: colorCommon.bgColor,
          //             fontFamily: "family",
          //             fontSize: 40),
          //       )),
          // ),
          // GestureDetector(
          //   onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (context) {
          //       return const OptionSelect();
          //     },
          //   )),
          //   child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: colorCommon.yColor,
          //       ),
          //       alignment: Alignment.center,
          //       width: 300,
          //       height: 90,
          //       child: Text(
          //         "FRIENDS",
          //         style: TextStyle(
          //             color: colorCommon.bgColor,
          //             fontFamily: "family",
          //             fontSize: 40),
          //       )).paddingOnly(top: 10),
          // ),
        ],
      ),
    );
  }
}

Widget chooseButton({required BuildContext context, required String title}) {
  bool isOnePlayer = title == 'Ai';
  return GestureDetector(
    child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colorCommon.yColor,
        ),
        alignment: Alignment.center,
        width: 300,
        height: 90,
        child: Text(
          title,
          style: TextStyle(
              color: colorCommon.bgColor, fontFamily: "family", fontSize: 40),
        )).paddingOnly(top: 10),
    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return PlayWithFriends(isOnePlayer: isOnePlayer);
      },
    )),
  );
}

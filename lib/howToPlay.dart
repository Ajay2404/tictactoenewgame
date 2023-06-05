import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tictactoenewgame/config.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCommon.bgColor,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 60,
          ),
          Text(
            "HOW TO PLAY?",
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'family',
              color: colorCommon.yColor,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 70, bottom: 70, right: 20, left: 20),
            alignment: Alignment.center,
            child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'family',
                  color: colorCommon.bgColor,
                ),
                """To play Tic-Tac-Toe, follow these steps:

Decide which player will be 'X' and which player will be 'O'.

Player X starts the game by placing their symbol ('X') in any empty square on the grid.

Player O takes their turn and places their symbol ('O') in any remaining empty square.

Players take turns placing their symbols on the grid, one at a time, until the game ends.

The objective is to get three of your symbols in a row (horizontally, vertically, or diagonally).

Continue taking turns until one of the following conditions is met:

One player achieves a winning combination of three symbols in a row and is declared the winner.
All squares on the grid are filled, resulting in a draw.
If a player wins or the game ends in a draw, you can start a new game and take turns again.

Remember, you need to strategize and try to block your opponent's moves while creating your own opportunities to form a winning combination. Good luck and enjoy playing Tic-Tac-Toe!"""),
            decoration: BoxDecoration(
                color: colorCommon.yColor,
                borderRadius: BorderRadius.circular(30)),
          ).paddingOnly(top: 30, left: 10, right: 10, bottom: 30),
        ]),
      ),
    );
  }
}

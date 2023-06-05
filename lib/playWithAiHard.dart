import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tictactoenewgame/config.dart';

import 'main.dart';

class PlayWithAi extends StatefulWidget {
  const PlayWithAi(
      {Key? key,
      required this.firstPlayerOption,
      required this.playerName,
      required this.secondPlayerOption})
      : super(key: key);
  final String playerName;
  final String firstPlayerOption;
  final String secondPlayerOption;

  @override
  State<PlayWithAi> createState() => _PlayWithAiState();
}

class _PlayWithAiState extends State<PlayWithAi> {
  AudioPlayer audioPlayer = AudioPlayer();
  final String oWinSoundPath = 'audioasset/owins.mp3';
  final String xWinSoundPath = 'audioasset/xwins.mp3';
  List<String> boardState = List.filled(9, '');
  bool isPlayerOneTurn = true;
  int countLeft = 0;
  int countRight = 0;
  int tiesCount = 0;
  bool highlightCountLeft = true;
  bool highlightCountRight = false;
  bool isTie = false;
  List<List<int>> winningConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];
  bool gameOver = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> checkWinner() async {
    for (var combination in winningConditions) {
      if (boardState[combination[0]] != '' &&
          boardState[combination[0]] == boardState[combination[1]] &&
          boardState[combination[1]] == boardState[combination[2]]) {
        setState(() {
          gameOver = true;
        });
        await audioPlayer.setAsset(oWinSoundPath);
        await audioPlayer.load();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            String winningPlayer = boardState[combination[0]];
            String audioPath =
                winningPlayer == "O" ? oWinSoundPath : xWinSoundPath;
            audioPlayer.setAsset(audioPath);
            audioPlayer.play();
            return AlertDialog(
              backgroundColor: colorCommon.yColor,
              content: Text(
                'Player ${boardState[combination[0]]} wins!',
                style: TextStyle(
                  fontFamily: "family",
                  fontSize: 25,
                  color: colorCommon.bgColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    resetGame();
                  },
                  child: Text(
                    "Play Again",
                    style: TextStyle(
                      fontFamily: "family",
                      fontSize: 20,
                      color: colorCommon.bgColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
        setState(() {
          if (boardState[combination[0]] == 'X') {
            countLeft++;
          } else if (boardState[combination[0]] == 'O') {
            countRight++;
          }
        });
        return;
      }
    }

    if (!boardState.contains('')) {
      setState(() {
        gameOver = true;
        tiesCount++;
      });
      await audioPlayer.setAsset('audioasset/mtie.mp3');
      await audioPlayer.load();
      showDialog(
        context: context,
        builder: (context) {
          audioPlayer.play();
          return AlertDialog(
            backgroundColor: colorCommon.yColor,
            title: Center(
              child: Text(
                "It's a Tie!",
                style: TextStyle(
                  fontFamily: "family",
                  fontSize: 25,
                  color: colorCommon.bgColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetGame();
                },
                child: Text(
                  "Play Again",
                  style: TextStyle(
                    fontFamily: "family",
                    fontSize: 20,
                    color: colorCommon.bgColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  void makeAIMove() {
    int bestScore = -9999;
    int bestMove = -1;

    for (int i = 0; i < 9; i++) {
      if (boardState[i] == '') {
        boardState[i] = 'O';
        int score = minimax(boardState, 0, false);
        boardState[i] = '';

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    if (bestMove != -1) {
      setState(() {
        boardState[bestMove] = 'O';
        isPlayerOneTurn = true;
      });

      checkWinner();
    }
  }

  int minimax(List<String> board, int depth, bool isMaximizingPlayer) {
    if (checkWinningCondition(board, 'X')) {
      return -1;
    } else if (checkWinningCondition(board, 'O')) {
      return 1;
    } else if (isBoardFull(board)) {
      return 0;
    }

    if (isMaximizingPlayer) {
      int bestScore = -9999;

      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'O';
          int score = minimax(board, depth + 1, false);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }

      return bestScore;
    } else {
      int bestScore = 9999;

      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'X';
          int score = minimax(board, depth + 1, true);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }

      return bestScore;
    }
  }

  bool checkWinningCondition(List<String> board, String player) {
    for (var combination in winningConditions) {
      if (board[combination[0]] == player &&
          board[combination[1]] == player &&
          board[combination[2]] == player) {
        return true;
      }
    }

    return false;
  }

  bool isBoardFull(List<String> board) {
    return !board.contains('');
  }

  void resetGame() {
    setState(() {
      boardState = List.filled(9, '');
      isPlayerOneTurn = true;
      highlightCountLeft = true;
      highlightCountRight = false;
      gameOver = false;
      isTie = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: colorCommon.bgColor,
          body: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: colorCommon.yColor,
                            title: Text(
                              textAlign: TextAlign.center,
                              "Are you sure you want to quit?",
                              style: TextStyle(
                                fontFamily: "family",
                                fontSize: 25,
                                color: colorCommon.bgColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Row(children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: colorCommon.bgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      fontFamily: "family",
                                      fontSize: 25,
                                      color: colorCommon.yColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ).paddingOnly(left: 10),
                              const SizedBox(
                                width: 70,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return const DashBoard();
                                  },
                                )),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: colorCommon.bgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontFamily: "family",
                                      fontSize: 25,
                                      color: colorCommon.yColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      height: 63,
                      "image/svg/back.svg",
                    )).paddingOnly(top: 20, left: 20),
                GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: colorCommon.yColor,
                            title: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "Are you sure you want to Restart?",
                                style: TextStyle(
                                  fontFamily: "family",
                                  fontSize: 25,
                                  color: colorCommon.bgColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            content: Row(children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: colorCommon.bgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      fontFamily: "family",
                                      fontSize: 25,
                                      color: colorCommon.yColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ).paddingOnly(left: 10),
                              const SizedBox(
                                width: 60,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  resetGame();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 60,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: colorCommon.bgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontFamily: "family",
                                      fontSize: 25,
                                      color: colorCommon.yColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      "image/svg/restart.svg",
                    )).paddingOnly(top: 20, right: 20),
              ],
            ).paddingOnly(bottom: 30),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!gameOver && boardState[index] == '') {
                      setState(() {
                        boardState[index] = 'X';
                        isPlayerOneTurn = !isPlayerOneTurn;
                      });

                      checkWinner();

                      if (!gameOver) {
                        makeAIMove();
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorCommon.yColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        boardState[index],
                        style: TextStyle(
                          fontFamily: "family",
                          fontSize: 50.0,
                          color: colorCommon.bgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 20),
                Container(
                    width: 110,
                    alignment: Alignment.center,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isPlayerOneTurn && highlightCountLeft
                          ? Colors.white
                          : (!isPlayerOneTurn && highlightCountRight
                              ? colorCommon.yColor
                              : colorCommon.yColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.firstPlayerOption,
                          style: TextStyle(
                            fontFamily: "family",
                            fontSize: 30.0,
                            color: colorCommon.bgColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$countLeft",
                          style: const TextStyle(
                              fontFamily: "family1",
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Container(
                  decoration: BoxDecoration(
                      color: colorCommon.yColor,
                      borderRadius: BorderRadius.circular(10)),
                  width: 110,
                  height: 120,
                  child: Column(
                    children: [
                      Text(
                        "TIES",
                        style: TextStyle(
                          fontFamily: "family",
                          fontSize: 30,
                          color: colorCommon.bgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$tiesCount",
                        style: const TextStyle(
                            fontFamily: "family1",
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 110,
                  alignment: Alignment.topCenter,
                  height: 120,
                  decoration: BoxDecoration(
                    color: isPlayerOneTurn && highlightCountRight
                        ? Colors.white
                        : (!isPlayerOneTurn && highlightCountLeft
                            ? Colors.white
                            : colorCommon.yColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.secondPlayerOption,
                        style: TextStyle(
                          fontFamily: "family",
                          fontSize: 30,
                          color: colorCommon.bgColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$countRight",
                        style: const TextStyle(
                            fontFamily: "family1",
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ])),
    );
  }
}

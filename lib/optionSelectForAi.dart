// import 'package:flutter/material.dart';
// import 'package:tictactoenewgame/config.dart';
// import 'package:tictactoenewgame/playWithAiHard.dart';
//
// class OptionSelectForAi extends StatefulWidget {
//   const OptionSelectForAi({Key? key}) : super(key: key);
//
//   @override
//   State<OptionSelectForAi> createState() => _OptionSelectForAiState();
// }
//
// class _OptionSelectForAiState extends State<OptionSelectForAi> {
//   bool isSelectedX = true;
//   bool isSelectedO = false;
//   String firstPlayerOption = '';
//   late String userSide;
//   late String aiSide;
//
//   Future<void> navigateToNextPage() async {
//     String userPlayerOption = firstPlayerOption;
//     String aiPlayerOption = userPlayerOption == 'O' ? 'X' : 'O';
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) {
//         return PlayWithAi(
//             firstPlayerOption: firstPlayerOption,
//             playerName: "",
//             secondPlayerOption: "");
//       }),
//     );
//     await Future.delayed(const Duration(seconds: 1));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorCommon.bgColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('X'),
//               Radio(
//                 value: 'O',
//                 groupValue: userSide,
//                 onChanged: (value) {
//                   setState(() {
//                     userSide = value!;
//                     aiSide = userSide == 'X' ? 'O' : 'X';
//                   });
//                 },
//               ),
//               Text('O'),
//             ],
//           ),
//           Center(
//             child: Text(
//               "Choose a side",
//               style: TextStyle(
//                 fontFamily: "family",
//                 fontSize: 40.0,
//                 color: colorCommon.yColor,
//               ),
//             ),
//           ),
//           const SizedBox(height: 100),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 isSelectedX = true;
//                 isSelectedO = false;
//                 firstPlayerOption = 'X';
//               });
//               navigateToNextPage();
//             },
//             child: Container(
//               alignment: Alignment.center,
//               height: 280,
//               width: 370,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(40),
//                 color: isSelectedX ? colorCommon.yColor : null,
//               ),
//               child: Text(
//                 "X",
//                 style: TextStyle(
//                   fontFamily: "family",
//                   fontSize: 130,
//                   color: isSelectedO ? colorCommon.yColor : colorCommon.bgColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 isSelectedX = false;
//                 isSelectedO = true;
//                 firstPlayerOption = 'O';
//               });
//               navigateToNextPage();
//             },
//             child: Container(
//               alignment: Alignment.center,
//               height: 280,
//               width: 370,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(40),
//                 color: isSelectedO ? colorCommon.yColor : null,
//               ),
//               child: Text(
//                 "o",
//                 style: TextStyle(
//                   fontFamily: "family",
//                   fontSize: 150,
//                   color: isSelectedO ? colorCommon.bgColor : colorCommon.yColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

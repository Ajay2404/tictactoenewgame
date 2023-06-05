// import 'package:flutter/material.dart';
// import 'package:tictactoenewgame/config.dart';
// import 'package:tictactoenewgame/playWithFriends.dart';
//
// class OptionSelect extends StatefulWidget {
//   final bool isOnePlayer;
//
//   const OptionSelect({Key? key, required this.isOnePlayer}) : super(key: key);
//
//   @override
//   State<OptionSelect> createState() => _OptionSelectState();
// }
//
// class _OptionSelectState extends State<OptionSelect> {
//   bool isSelectedX = true;
//   bool isSelectedO = false;
//   String firstPlayerOption = '';
//
//   Future<void> navigateToNextPage() async {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) {
//         return PlayWithFriends(
//           playerName: '',
//           firstPlayerOption: firstPlayerOption,
//           secondPlayerOption: firstPlayerOption == 'X' ? 'O' : 'X',
//         );
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

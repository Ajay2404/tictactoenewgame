import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tictactoenewgame/config.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    Future.delayed(const Duration(seconds: 4)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return DashBoard();
        },
      ));
    });

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
      body: Stack(
        children: [
          Center(child: SvgPicture.asset("image/svg/splash.svg", height: 300)),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: animation.value,
                child: Text(
                  'X',
                  style: TextStyle(
                      fontFamily: "family",
                      fontSize: 110.0,
                      color: colorCommon.bgColor),
                ),
              );
            },
          ).paddingOnly(top: 300, left: 90),
          Text(
            'O',
            style: TextStyle(
                fontFamily: "family",
                fontSize: 110.0,
                color: colorCommon.bgColor),
          ).paddingOnly(top: 290, left: 230),
          Text(
            'O',
            style: TextStyle(
                fontFamily: "family",
                fontSize: 110.0,
                color: colorCommon.bgColor),
          ).paddingOnly(top: 440, left: 95),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Transform.rotate(
                angle: animation.value,
                child: Text(
                  'X',
                  style: TextStyle(
                      fontFamily: "family",
                      fontSize: 110.0,
                      color: colorCommon.bgColor),
                ),
              );
            },
          ).paddingOnly(top: 435, left: 230),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FlipDigit extends StatefulWidget {
  final String number;
  const FlipDigit({super.key, this.number = '0'});

  @override
  State<FlipDigit> createState() => _FlipDigitState();
}

class _FlipDigitState extends State<FlipDigit>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // timer = Timer.periodic(const Duration(seconds: 2), (timer) {});
    animationController.forward();
    animationController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          animationController.repeat();
        }
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: AnimatedBuilder(
        animation: animationController,
        child: Text(
          widget.number,
          style: const TextStyle(
              fontFamily: "RubikMono",
              fontWeight: FontWeight.bold,
              fontSize: 900,
              color: Colors.white),
        ),
        builder: (BuildContext context, Widget? widget) {
          return Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(animationController.value * pi),
            child: widget,
          );
        },
      ),
    );
  }
}

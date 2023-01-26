import 'dart:developer';
import 'dart:math' as Math;

import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({super.key});

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

//указываем миксин
class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> moveDown;
  late Animation<double> scale;
  late Animation<BorderRadius?> borderRadius;
  late Animation<Color?> colorContainer;

  @override
  void initState() {
    //так как наш animation widget уже имеет примесь SingleTicket, то можно просто писать this
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    rotation = Tween(begin: 0.0, end: 3.0 * Math.pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.bounceIn,
      ),
    );
    opacity = Tween(begin: 0.0, end: 1.0).animate(controller);
    moveDown = Tween(begin: 0.0, end: 200.0).animate(controller);
    scale = Tween(begin: 0.0, end: 1.0).animate(controller);

    borderRadius = BorderRadiusTween(
            begin: BorderRadius.circular(4), end: BorderRadius.circular(75))
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.375,
          0.500,
          curve: Curves.ease,
        ),
      ),
    );
    colorContainer =
        ColorTween(begin: Colors.indigo[100], end: Colors.red[400]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.500,
          0.750,
          curve: Curves.ease,
        ),
      ),
    );

    controller.addListener(() {
      log('Status: ${controller.status}');
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
        // } else if (controller.status == AnimationStatus.dismissed) {
        //   controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.repeat();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: colorContainer.value,
            border: Border.all(color: Colors.indigo, width: 3),
            borderRadius: borderRadius.value,
          ),
        );
        // print(rotation.status);
        // print(opacity.status);
        // return Transform.scale(
        //   scale: scale.value,
        //   child: Transform.translate(
        //     offset: Offset(0.0, moveDown.value),
        //     child: Transform.rotate(
        //       angle: rotation.value,
        //       child: Opacity(
        //         opacity: opacity.value,
        //         child: Container(
        //           height: 100,
        //           width: 100,
        //           decoration: BoxDecoration(
        //               color: colorContainer.value,
        //               borderRadius: borderRadius.value),
        //         ),
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../main.dart';

class SplashScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    AnimationController animationController = useAnimationController(duration: const Duration(seconds: 4), initialValue: 1);
    animationController.repeat(reverse: false);

    AnimationController controller = useAnimationController(duration: const Duration(seconds: 3), initialValue: 1);
    controller.repeat(reverse: false, period: const Duration(seconds: 4));

    controller = useAnimationController(duration: const Duration(seconds: 3), initialValue: 1);
    controller.repeat(reverse: false, period: const Duration(seconds: 4));

    Animation< Offset > offset = Tween< Offset >(begin: const Offset(0.0, 1.0), end:     Offset.zero).animate(controller);
    controller.forward();

    useEffect(() {
      Timer.periodic(const Duration(seconds: 4), (time) {
        Route route = MaterialPageRoute(builder: (context) => const MainPage());
        Navigator.of(context).pushReplacement(route);
      });
      return (){};
    });

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xffE3F3FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            FadeTransition(
                  opacity: animationController,
                  child: const Center(
                    child: FlutterLogo(
                      size: 100,
                    )),
             ),
            // Align(
                // alignment: Alignment.bottomCenter,
                // child: SlideTransition(
                //   position: offset,
                //   child: Image.asset(
                //     'assets/images/splash_bg.png',
                //     width: MediaQuery.of(context).size.width,
                //     fit: BoxFit.fill,
                //   ),
                // ))
          ],
        ),
      ),
    ));
  }
}
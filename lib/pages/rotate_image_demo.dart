import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

String url = "https://bit.ly/3qwBNUF";

class ImageRotateDemo extends HookWidget {
  const ImageRotateDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(onListen: () {
      controller.sink.add(0.0);
    });
    return Scaffold(
      body: StreamBuilder<double>(
          stream: controller.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              final rotation = snapshot.data ?? 0.0;
              return GestureDetector(
                onTap: () => controller.sink.add(rotation + 10.0),
                child: RotationTransition(
                    turns: AlwaysStoppedAnimation(rotation / 360.0),
                    child: Center(child: Image.network(url))),
              );
            }
          }),
    );
  }
}

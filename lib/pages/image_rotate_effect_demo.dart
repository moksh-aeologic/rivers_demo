import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

String url = "https://bit.ly/3qwBNUF";

enum Action { rorateLeft, rotateRight, moreVisible, lessVisible }

@immutable
class State {
  final double rotationDeg;
  final double alpha;
  const State({required this.rotationDeg, required this.alpha});
  const State.zero()
      : rotationDeg = 0.0,
        alpha = 1.0;

  State rotateRight() => State(rotationDeg: rotationDeg + 10.0, alpha: alpha);
  State rotateLeft() => State(rotationDeg: rotationDeg - 10.0, alpha: alpha);
  State increaseAlpha() =>
      State(rotationDeg: rotationDeg, alpha: min(alpha + 0.1, 1.0));
  State decreaseAlpha() =>
      State(rotationDeg: rotationDeg, alpha: min(alpha - 0.1, 1.0));
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rorateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();

    case Action.moreVisible:
      return oldState.increaseAlpha();

    case Action.lessVisible:
      return oldState.decreaseAlpha();

    case null:
      return oldState;
  }
}

class ImageRotateEffectDemo extends HookWidget {
  const ImageRotateEffectDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(reducer,
        initialState: const State.zero(), initialAction: null);
    return Scaffold(
      appBar: AppBar(title: const Text("alpha values")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => store.dispatch(Action.rorateLeft),
                  child: const Text('Rotate left')),
              TextButton(
                  onPressed: () => store.dispatch(Action.rotateRight),
                  child: const Text('Rotate Right')),
              TextButton(
                  onPressed: () => store.dispatch(Action.moreVisible),
                  child: const Text('+ alpha')),
              TextButton(
                  onPressed: () => store.dispatch(Action.lessVisible),
                  child: const Text('- alpha'))
            ],
          ),
          const SizedBox(height: 100),
          Opacity(
            opacity: store.state.alpha,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(store.state.rotationDeg / 360),
              child: Center(
                child: Image.network(url),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameCompletedView extends StatefulWidget {
  const GameCompletedView(this.game, {super.key});

  final Game game;

  @override
  State<GameCompletedView> createState() => _GameCompletedViewState();
}

class _GameCompletedViewState extends State<GameCompletedView> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Center(
        child: Column(),
      ),
    );
  }
}

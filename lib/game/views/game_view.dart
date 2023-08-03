import 'package:flutter/widgets.dart';
import 'package:flame/game.dart';

class GameView extends StatefulWidget {
  const GameView(this.game, {super.key});

  final Game game;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

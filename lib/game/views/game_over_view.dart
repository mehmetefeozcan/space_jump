import 'package:flutter/widgets.dart';
import 'package:flame/game.dart';

class GameOverView extends StatefulWidget {
  const GameOverView(this.game, {super.key});

  final Game game;

  @override
  State<GameOverView> createState() => _GameOverViewState();
}

class _GameOverViewState extends State<GameOverView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key, required this.game, this.isLight = false});

  final Game game;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as MyGame).gameManager.score,
      builder: (context, value, child) {
        return SafeArea(
          child: Text(
            'Score: $value',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        );
      },
    );
  }
}

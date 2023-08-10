import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_jump/globals.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({
    super.key,
    required this.game,
    this.isLight = false,
    this.isCenter = false,
  });

  final Game game;
  final bool isLight;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (game as MyGame).gameManager.score,
      builder: (context, value, child) {
        return SafeArea(
          child: isCenter ? centered(value, context) : multiple(value, context),
        );
      },
    );
  }

  Widget centered(int value, BuildContext context) {
    return Text(
      'Score: $value',
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.white),
    );
  }

  Widget multiple(int value, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Score: $value',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
          Text(
            'Seviye ${gameLevelModel.value.level}',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

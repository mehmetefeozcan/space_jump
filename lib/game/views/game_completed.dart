import 'package:space_jump/game/core/utils/index.dart';
import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GameCompletedView extends StatefulWidget {
  const GameCompletedView(this.game, {super.key});

  final Game game;

  @override
  State<GameCompletedView> createState() => _GameCompletedViewState();
}

class _GameCompletedViewState extends State<GameCompletedView> {
  @override
  void initState() {
    Levels().updateLevel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyGame game = widget.game as MyGame;

    return Material(
      color: Colors.black.withOpacity(0.2),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Level Completed!",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                game.remove(game.player);
                game.objectManager.resetGame();
                game.resetGame();
                setState(() {});
              },
              child: Text(
                "Next Level",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () => game.goMainMenu(),
              child: Text(
                "Back Menu",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

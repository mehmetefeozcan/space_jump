import 'package:space_jump/game/core/enums/index.dart';
import 'package:space_jump/game/core/utils/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/game.dart';
import 'package:space_jump/globals.dart';
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

    addGold();
    super.initState();
  }

  addGold() async {
    final box = Hive.box(HiveEnums.gameBox.value);
    if (box.get(HiveEnums.gold.value) != null) {
      int gold = box.get(HiveEnums.gold.value);
      await box.put(HiveEnums.gold.value, gold + gameLevelModel.value.gold!);
    }
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
            const SizedBox(height: 10),
            Text(
              "You earn ${gameLevelModel.value.gold} gold",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.orangeAccent),
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
              onTap: () {
                game.goMainMenu();
                setState(() {});
              },
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

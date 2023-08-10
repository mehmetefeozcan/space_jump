import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/core/enums/index.dart';
import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_jump/game/widgets/index.dart';
import 'package:space_jump/globals.dart';

class GameOverView extends StatefulWidget {
  const GameOverView(this.game, {super.key});

  final Game game;

  @override
  State<GameOverView> createState() => _GameOverViewState();
}

class _GameOverViewState extends State<GameOverView> {
  @override
  void initState() {
    addGold();
    super.initState();
  }

  addGold() async {
    final box = Hive.box(HiveEnums.gameBox.value);

    await box.put(HiveEnums.gold.value, gameLevelModel.value.gold);
  }

  @override
  Widget build(BuildContext context) {
    MyGame game = widget.game as MyGame;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Over',
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
              ScoreDisplay(
                game: game,
                isLight: true,
                isCenter: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  game.resetGame();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(100, 40),
                  ),
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text('Play Again'),
              ),
              const SizedBox(height: 20),
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
      ),
    );
  }
}

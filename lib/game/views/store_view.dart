import 'package:space_jump/game/core/enums/index.dart';
import 'package:space_jump/game/core/utils/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_jump/globals.dart';

class StoreView extends StatefulWidget {
  const StoreView(this.game, {super.key});

  final Game game;

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  int gold = 0;
  @override
  void initState() {
    final box = Hive.box(HiveEnums.gameBox.value);

    if ((box.get(HiveEnums.gold.value) == null)) {
      box.put(HiveEnums.gold.value, 0);
    } else if (box.get(HiveEnums.gold.value) != null) {
      gold = box.get(HiveEnums.gold.value);
    }

    Levels().setLevelStat();
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyGame game = widget.game as MyGame;

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Stack(
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    game.goMainMenu();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Text(
                    "Welcome Store\nGold: $gold",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  characterCard(
                      'assets/images/character/pl_grey_right.png', 'grey'),
                  const SizedBox(height: 30),
                  characterCard(
                      'assets/images/character/pl_green_right.png', 'green'),
                  const SizedBox(height: 30),
                  characterCard(
                      'assets/images/character/pl_pink_right.png', 'pink'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget characterCard(String image, String color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: characterColor.value == color ? Colors.amber : Colors.white,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            characterColor.value = color;
          });
        },
        child: Image.asset(
          image,
          scale: 0.3,
        ),
      ),
    );
  }
}

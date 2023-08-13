import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/core/enums/index.dart';
import 'package:space_jump/game/core/utils/index.dart';
import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_jump/globals.dart';

class MenuView extends StatefulWidget {
  const MenuView(this.game, {super.key});

  final Game game;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  void initState() {
    hiveAllInit();

    Levels().setLevelStat();

    setState(() {});
    super.initState();
  }

  Future hiveAllInit() async {
    final box = Hive.box(HiveEnums.gameBox.value);

    // For Gold
    if (box.get(HiveEnums.gold.value) == null) {
      box.put(HiveEnums.gold.value, 0);
    } else if (box.get(HiveEnums.gold.value) != null) {
      gold.value = box.get(HiveEnums.gold.value);
    }

    // For Character
    if (box.get(HiveEnums.character.value) == null) {
      box.put(HiveEnums.character.value, 'grey');
    } else if (box.get(HiveEnums.gold.value) != null) {
      characterColor.value = box.get(HiveEnums.character.value);
    }

    // For Store
    if (box.get(HiveEnums.store.value) == null) {
      final data = [
        {"type": "character", "color": "grey", "price": 0, "isUnlock": true},
        {"type": "character", "color": "green", "price": 10, "isUnlock": false},
        {"type": "character", "color": "pink", "price": 20, "isUnlock": false},
      ];
      box.put(HiveEnums.store.value, data);
    }
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
                Text(
                  "Gold: ${gold.value}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  Text(
                    "Welcome!\nSpace Jump Game",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      game.startGame();
                    },
                    child: Text(
                      "Start Level ${gameLevelModel.value.level}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      game.goStore();
                    },
                    child: Text(
                      "Store",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

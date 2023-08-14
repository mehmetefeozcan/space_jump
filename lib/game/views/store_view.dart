import 'package:space_jump/game/core/manager/index.dart';
import 'package:space_jump/game/models/store_model.dart';
import 'package:space_jump/game/core/enums/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/game.dart';
import 'package:space_jump/globals.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class StoreView extends StatefulWidget {
  const StoreView(this.game, {super.key});

  final Game game;

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late Box box;

  late List<StoreModel> storeData;

  Future changeCharacter(StoreModel model) async {
    characterColor.value = model.color!;
    box.put(HiveEnums.character.value, model.color!);
  }

  Future buyCharacter(StoreModel model, int index) async {
    if (gold.value >= model.price!) {
      // set selected character
      characterColor.value = model.color!;
      box.put(HiveEnums.character.value, model.color!);

      // increase total gold
      gold.value -= model.price!;
      box.put(HiveEnums.gold.value, gold.value);

      // update model
      storeData[index].isUnlock = true;

      // List<StoreModel> to List<Json>
      final data = storeData.map((e) => e.toJson()).toList();
      await box.put(HiveEnums.store.value, data);
    }
  }

  @override
  void initState() {
    box = Hive.box(HiveEnums.gameBox.value);
    List res = box.get(HiveEnums.store.value);
    storeData = (res).map((x) => StoreModel.fromJson(x)).toList();
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
                    game.overlays.remove('storeOverlay');
                    game.gameManager.state = GameState.main;
                    game.overlays.add('mainMenuOverlay');
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
                    "Welcome Store\nGold: ${gold.value}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: storeData.length,
                    itemBuilder: (context, index) {
                      return characterCard(context, storeData[index], index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget characterCard(BuildContext context, StoreModel model, int index) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding:
          EdgeInsets.only(left: width * 0.35, right: width * 0.35, bottom: 30),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(
            color: characterColor.value == model.color!
                ? Colors.amber
                : model.isUnlock!
                    ? Colors.white
                    : Colors.red,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () async {
            model.isUnlock!
                ? await changeCharacter(model)
                : await buyCharacter(model, index);
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/character/pl_${model.color!}_right.png',
                      scale: 0.4,
                    ),
                    Text(
                      model.isUnlock! ? "Select" : "${model.price} Gold",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              Center(
                child: model.isUnlock!
                    ? const SizedBox()
                    : Icon(
                        Icons.lock_outline,
                        color: Colors.black.withOpacity(0.8),
                        size: 40,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

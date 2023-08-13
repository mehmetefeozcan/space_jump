import 'package:space_jump/game/core/enums/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/game.dart';
import 'package:space_jump/game/models/store_model.dart';
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
                      return characterCard(storeData[index]);
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

  Widget characterCard(StoreModel model) {
    return Padding(
      padding: const EdgeInsets.only(left: 150, right: 150, bottom: 30),
      child: Container(
        width: 100,
        height: 100,
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
        child: Stack(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  model.isUnlock!
                      ? setState(() {
                          characterColor.value = model.color!;
                          box.put(HiveEnums.character.value, model.color!);
                        })
                      : setState(
                          () {
                            if (gold.value >= model.price!) {
                              characterColor.value = model.color!;
                              box.put(HiveEnums.character.value, model.color!);
                              gold.value -= model.price!;
                            }
                          },
                        );
                },
                child: Image.asset(
                  'assets/images/character/pl_${model.color!}_right.png',
                  scale: 0.4,
                ),
              ),
            ),
            model.isUnlock!
                ? const SizedBox()
                : Center(
                    child: Icon(
                      Icons.lock_outline,
                      color: Colors.black.withOpacity(0.8),
                      size: 80,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/core/enums/index.dart';
import 'package:space_jump/game/core/game_model.dart';
import 'package:space_jump/globals.dart';

class Levels {
  Future updateLevel() async {
    final box = Hive.box(HiveEnums.gameBox.value);

    final level = box.get(HiveEnums.level.value);

    await box.put(HiveEnums.level.value, level + 1);

    setLevelStat();
  }

  void setLevelStat() {
    final box = Hive.box(HiveEnums.gameBox.value);
    int level = 0;

    if (box.get(HiveEnums.level.value) == null) {
      box.put(HiveEnums.level.value, 1);
      level = box.get(HiveEnums.level.value);
    } else {
      level = box.get(HiveEnums.level.value);
    }
    if (level == 1) {
      gameLevelModel.value = GameLevelModel(
        // bölüm
        level: level,
        // bölüm max score
        highScore: 5,
        // bölüm gold
        gold: 5,
        // bölümün enemy olasılığı
        enemyProb: 0,
      );
    } else if (level > 1 && level <= 3) {
      gameLevelModel.value = GameLevelModel(
        level: level,
        highScore: 15,
        gold: 5,
        enemyProb: 3,
      );
    } else if (level > 3 && level <= 5) {
      gameLevelModel.value = GameLevelModel(
        level: level,
        highScore: 20,
        gold: 7,
        enemyProb: 5,
      );
    } else if (level > 5 && level <= 10) {
      gameLevelModel.value = GameLevelModel(
        level: level,
        highScore: 30,
        gold: 9,
        enemyProb: 10,
      );
    }
  }
}

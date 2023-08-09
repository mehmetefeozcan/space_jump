import 'package:space_jump/game/core/game_model.dart';
import 'package:space_jump/globals.dart';

class Levels {
  void setLevelStat(int level) {
    if (level == 1) {
      gameLevelModel = GameLevelModel(
        // bölüm
        level: level,
        // bölüm max score
        highScore: 5,
        // bölüm gold
        gold: 5,
        // bölümün enemy olasılığı
        enemyProb: 0,
      );
    } else if (level > 1 && level < 4) {
      gameLevelModel = GameLevelModel(
        level: level,
        highScore: 15,
        gold: 5,
        enemyProb: 5,
      );
    }
  }
}

class GameLevelModel {
  int? level;
  int? enemyProb;
  int? highScore;
  int? gold;

  GameLevelModel({this.level, this.enemyProb, this.highScore, this.gold});

  GameLevelModel.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    enemyProb = json['enemyProb'];
    highScore = json['highScore'];
    gold = json['gold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['enemyProb'] = enemyProb;
    data['highScore'] = highScore;
    data['gold'] = gold;
    return data;
  }
}

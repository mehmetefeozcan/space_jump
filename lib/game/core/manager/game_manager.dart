import 'package:space_jump/game/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:space_jump/globals.dart';

enum GameState { main, playing, gameOver, paused, completed }

class GameManager extends Component with HasGameRef<MyGame> {
  GameManager();

  GameState state = GameState.main;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isMain => state == GameState.main;
  bool get isPaused => state == GameState.paused;
  bool get isComp => state == GameState.completed;

  ValueNotifier<int> score = ValueNotifier(0);

  ValueNotifier<double> gamePercent = ValueNotifier(0.0);

  void reset() {
    score.value = 0;
    gamePercent.value = 0;

    state = GameState.main;
  }

  void increaseScore() {
    score.value++;
  }

  void increasePercent() {
    gamePercent.value =
        ((100 * score.value) / gameLevelModel.value.highScore!) / 100;
  }
}

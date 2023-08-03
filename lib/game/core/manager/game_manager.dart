import 'package:space_jump/game/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum GameState { intro, playing, gameOver }

class GameManager extends Component with HasGameRef<MyGame> {
  GameManager();

  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;

  ValueNotifier<int> score = ValueNotifier(0);

  void reset() {
    score.value = 0;
    state = GameState.intro;
  }

  void increaseScore() {
    score.value++;
  }
}

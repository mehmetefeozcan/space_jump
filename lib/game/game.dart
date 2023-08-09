// ignore_for_file: deprecated_member_use

import 'package:space_jump/game/core/manager/index.dart';
import 'package:space_jump/game/sprites/index.dart';
import 'package:space_jump/game/world.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:async';

import 'package:space_jump/globals.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  MyGame({super.children});

  // Set managers
  ObjectManager objectManager = ObjectManager();
  GameManager gameManager = GameManager();

  // Set World
  final MyWorld world = MyWorld();
  late MyPlayer player;

  // Other Variables
  int screenBufferSpace = 300;

  @override
  Future<void> onLoad() async {
    // Add world in game
    await add(world);

    // Add game manager in game
    await add(gameManager);

    // Add gameOverlay in the background
    overlays.add('gameOverlay');

    // show coordinte
    debugMode = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameManager.score.value == gameLevelModel.highScore) {
      gameManager.state = GameState.completed;
      pauseEngine();
    }

    if (gameManager.isGameOver) {
      return;
    }

    if (gameManager.isPaused) {
      overlays.add('pauseOverlay');
      pauseEngine();
      return;
    }

    if (gameManager.isIntro) {
      overlays.add('mainMenuOverlay');
      return;
    }

    if (gameManager.isComp) {
      overlays.add('completeOverlay');

      return;
    }

    if (gameManager.isPlaying) {
      final Rect worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + world.size.y,
      );
      camera.worldBounds = worldBounds;
      if (player.isMovingDown) {
        camera.worldBounds = worldBounds;
      }

      var isInTopHalfOfScreen = player.position.y <= (world.size.y / 2);
      if (!player.isMovingDown && isInTopHalfOfScreen) {
        camera.followComponent(player);
      }

      if (player.position.y >
          camera.position.y +
              world.size.y +
              player.size.y +
              screenBufferSpace) {
        loseGame();
      }
      return;
    }
  }

  void startGame() {
    initializeGame();
    gameManager.state = GameState.playing;
    overlays.remove('mainMenuOverlay');
  }

  void loseGame() {
    gameManager.state = GameState.gameOver;
    player.removeFromParent();
    overlays.add('gameOverOverlay');
  }

  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
  }

  void pauseGame() {
    if (gameManager.isPaused) {
      gameManager.state = GameState.playing;
      overlays.remove('pauseOverlay');
      resumeEngine();
    } else {
      gameManager.state = GameState.paused;
    }
  }

  void goMainMenu() {
    resumeEngine();
    remove(player);

    gameManager.state = GameState.intro;

    objectManager.resetGame();
    overlays.remove('pauseOverlay');
  }

  void initializeGame() {
    // character add in game
    setCharacter();
    // reset game states
    gameManager.reset();
    // clear previously added
    if (children.contains(objectManager)) objectManager.removeFromParent();
    // reset player stat
    player.reset();
    // set camera follow
    camera.worldBounds = Rect.fromLTRB(
      0,
      -world.size.y,
      camera.gameSize.x,
      world.size.y + screenBufferSpace,
    );
    camera.followComponent(player);

    objectManager = ObjectManager();

    add(objectManager);
  }

  // if you have many character comp select and init in this code block
  Future setCharacter() async {
    player = MyPlayer();
    await add(player);
  }
}

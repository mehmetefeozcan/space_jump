import 'package:space_jump/game/core/manager/index.dart';
import 'package:space_jump/game/core/utils/index.dart';
import 'package:space_jump/game/sprites/index.dart';
import 'package:space_jump/game/game.dart';
import 'package:space_jump/globals.dart';
import 'package:flame/components.dart';
import 'dart:math';

final Random random = Random();

class ObjectManager extends Component with HasGameRef<MyGame> {
  ObjectManager();

  // platform distance
  double minVerticalDistanceToNextPlatform = 290;
  double maxVerticalDistanceToNextPlatform = 300;

  // platfom & enemy list
  final List<Platform> platforms = [];
  final List<Platform> enemies = [];

  // platform and enemy generate probability
  final probGen = ProbabilityGenerator();
  final double tallestPlatformHeight = 40;
  GameManager gameManager = GameManager();

  @override
  void onMount() {
    super.onMount();

    var currentX = (gameRef.size.x.floor() / 2).toDouble() - 50;

    var currentY =
        gameRef.size.y - (random.nextInt(gameRef.size.y.floor()) / 3) - 50;

    for (var i = 0; i < 10; i++) {
      if (i != 0) {
        currentX = generateNextX(100);
        currentY = generateNextY();
      }
      platforms.add(
        Platform(
          position: Vector2(currentX, currentY),
        ),
      );

      add(platforms[i]);
    }
  }

  @override
  void update(double dt) {
    if (game.gameManager.isPlaying) {
      final topOfLowestPlatform =
          platforms.first.position.y + tallestPlatformHeight;

      final screenBottom = gameRef.player.position.y +
          (gameRef.size.x / 2) +
          gameRef.screenBufferSpace;

      if (topOfLowestPlatform > screenBottom) {
        var newPlatY = generateNextY();
        var newPlatX = generateNextX(100);
        final nextPlat = Platform(
          position: Vector2(newPlatX, newPlatY),
        );
        add(nextPlat);

        platforms.add(nextPlat);

        gameRef.gameManager.increaseScore();
        gameRef.gameManager.increasePercent();

        deletePlatform();
        generateEnemy(newPlatX, newPlatY);
      }
    }

    super.update(dt);
  }

  // for delete platforms at the bottom of the screen
  void deletePlatform() {
    final lowestPlat = platforms.removeAt(0);
    lowestPlat.removeFromParent();
  }

  // for delete enemies at the bottom of the screen
  void deleteEnemy() {
    final screenBottom = gameRef.player.position.y +
        (gameRef.size.x / 2) +
        gameRef.screenBufferSpace;

    while (enemies.isNotEmpty && enemies.first.position.y > screenBottom) {
      remove(enemies.first);
      enemies.removeAt(0);
    }
  }

  Future generateEnemy(double xAxis, double yAxis) async {
    if (probGen.generateWithProbability(
      gameLevelModel.value.enemyProb!.toDouble(),
    )) {
      var newPlatY = generateNextY();
      var newPlatX = generateNextX(100);

      if (xAxis >= newPlatX - 50 && xAxis <= newPlatX + 150) {
        var enemy = Platform(
          position: Vector2(newPlatX, newPlatY),
        );
        add(enemy);
        enemies.add(enemy);

        deleteEnemy();
      }
    }
  }

  double generateNextX(int platformWidth) {
    final previousPlatformXRange = Range(
      start: platforms.last.position.x,
      end: platforms.last.position.x + platformWidth,
    );

    double nextPlatformAnchorX;

    do {
      nextPlatformAnchorX =
          random.nextInt(gameRef.size.x.floor() - platformWidth).toDouble();
    } while (previousPlatformXRange.overlaps(
      Range(
          start: nextPlatformAnchorX, end: nextPlatformAnchorX + platformWidth),
    ));

    return nextPlatformAnchorX;
  }

  double generateNextY() {
    final currentHighestPlatformY =
        platforms.last.center.y + tallestPlatformHeight;

    final distanceToNextY = minVerticalDistanceToNextPlatform.toInt() +
        random
            .nextInt((maxVerticalDistanceToNextPlatform -
                    minVerticalDistanceToNextPlatform)
                .floor())
            .toDouble();

    return currentHighestPlatformY - distanceToNextY;
  }

  void resetGame() {
    while (enemies.isNotEmpty) {
      remove(enemies.first);
      enemies.removeAt(0);
    }
    while (platforms.isNotEmpty) {
      remove(platforms.first);
      platforms.removeAt(0);
    }
  }
}

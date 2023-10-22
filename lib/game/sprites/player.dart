import 'package:space_jump/game/core/manager/index.dart';
import 'package:space_jump/game/sprites/index.dart';
import 'package:space_jump/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:space_jump/globals.dart';

enum PlayerState { right, left }

class MyPlayer extends SpriteGroupComponent<PlayerState>
    with
        HasGameRef<MyGame>,
        KeyboardHandler,
        CollisionCallbacks,
        KeyboardHandler {
  MyPlayer({super.position, this.jumpSpeed = 560})
      : super(size: Vector2(80, 110), anchor: Anchor.center, priority: 1);

  double jumpSpeed;
  int hAxisInput = 0;
  final double gravity = 11;
  final int movingLeftInput = -1;
  final int movingRightInput = 1;
  Vector2 velocity = Vector2.zero();
  bool get isMovingDown => velocity.y > 0;

  GameManager gameManager = GameManager();

  // for the collision detection
  RectangleHitbox characterHitbox = RectangleHitbox(size: Vector2(80, 110));

  int bounce = 100;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // add character hitbox

    await add(characterHitbox);

    await loadCharacterSprites();
    current = PlayerState.right;
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.isMain ||
        gameRef.gameManager.isGameOver ||
        gameRef.gameManager.isPaused) return;

    velocity.x = hAxisInput * jumpSpeed;

    final double dashHorizontalCenter = size.x / 2;

    // Ekran Sınırlarından geri sekme için
    if (position.x < dashHorizontalCenter) {
      position.x += bounce;
      current = PlayerState.right;
    }
    if (position.x > gameRef.size.x - (dashHorizontalCenter)) {
      position.x -= bounce;
      current = PlayerState.left;
    }

    velocity.y += gravity;

    position += velocity * dt;
    super.update(dt);
  }

  moveRight() {
    hAxisInput = 0;
    current = PlayerState.right;
    hAxisInput -= movingLeftInput;
  }

  moveLeft() {
    hAxisInput = 0;
    current = PlayerState.left;

    hAxisInput += movingLeftInput;
  }

  resetDirection() => hAxisInput = 0;

  // character jump event
  void jump({double? specialJumpSpeed}) {
    velocity.y = specialJumpSpeed != null ? -specialJumpSpeed : -jumpSpeed;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // if the contact is with the enemy
    /*  if (other is Platform && gameRef.gameManager.isPlaying) {
      gameRef.loseGame();
      return;
    } */

    bool isCollidingVertically = true;

    if (intersectionPoints.last.y == other.position.y) {
      isCollidingVertically =
          (intersectionPoints.first.y - intersectionPoints.last.y) < 5.0;
    }

    // if the contact is with the platform
    if (isMovingDown && isCollidingVertically) {
      switch (other) {
        case Platform():
          jump();
          return;
      }
    }
  }

  void reset() {
    velocity = Vector2.zero();
    current = PlayerState.right;
    position = Vector2(gameRef.size.x / 2, gameRef.size.y / 2);
  }

  Future<void> loadCharacterSprites() async {
    // Load & configure sprite assets
    final left = await gameRef
        .loadSprite('character/pl_${characterColor.value}_left.png');
    final right = await gameRef
        .loadSprite('character/pl_${characterColor.value}_right.png');

    sprites = <PlayerState, Sprite>{
      PlayerState.left: left,
      PlayerState.right: right,
    };
  }
}

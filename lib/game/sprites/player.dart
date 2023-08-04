import 'package:flame/collisions.dart';
import 'package:space_jump/game/core/manager/index.dart';
import 'package:space_jump/game/game.dart';
import 'package:flame/components.dart';
import 'package:space_jump/game/sprites/index.dart';

enum PlayerState { right, left }

class MyPlayer extends SpriteGroupComponent<PlayerState>
    with
        HasGameRef<MyGame>,
        KeyboardHandler,
        CollisionCallbacks,
        KeyboardHandler {
  MyPlayer({super.position, this.jumpSpeed = 650})
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
  RectangleHitbox characterHitbox = RectangleHitbox(size: Vector2(70, 100));

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
    if (gameRef.gameManager.isIntro ||
        gameRef.gameManager.isGameOver ||
        gameRef.gameManager.isPaused) return;

    velocity.x = hAxisInput * jumpSpeed;

    final double dashHorizontalCenter = size.x / 2;

    if (position.x < dashHorizontalCenter) {
      position.x = gameRef.size.x - (dashHorizontalCenter);
    }
    if (position.x > gameRef.size.x - (dashHorizontalCenter)) {
      position.x = dashHorizontalCenter;
    }

    velocity.y += gravity;

    position += velocity * dt;
    super.update(dt);
  }

  moveRight() {
    hAxisInput = 0;
    current = PlayerState.right;

    hAxisInput += movingRightInput;
  }

  moveLeft() {
    hAxisInput = 0;
    current = PlayerState.left;

    hAxisInput += movingLeftInput;
  }

  resetDirection() => hAxisInput = 0;

  // character jump event
  void jump({double? specialJumpSpeed}) =>
      velocity.y = specialJumpSpeed != null ? -specialJumpSpeed : -jumpSpeed;

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // if the contact is with the enemy
    if (other is EnemyPlatform) {
      gameRef.loseGame();
      return;
    }

    bool isCollidingVertically =
        (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

    // if the contact is with the platform
    if (isMovingDown && isCollidingVertically) {
      switch (other) {
        case NormalPlatform():
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
    final left = await gameRef.loadSprite('character/pl_grey_left.png');
    final right = await gameRef.loadSprite('character/pl_grey_right.png');

    sprites = <PlayerState, Sprite>{
      PlayerState.left: left,
      PlayerState.right: right,
    };
  }
}

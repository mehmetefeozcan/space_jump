import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:async';

import 'package:space_jump/game/game.dart';
import 'package:space_jump/game/sprites/index.dart';

enum PlayerState { jumping, falling, hit }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MyGame>, KeyboardHandler, CollisionCallbacks {
  String character;
  Player({position, required this.character}) : super(position: position);

  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;
  late final SpriteAnimation fallingAnimation;

  final double _stepTime = 0.05;
  final double _gravity = 9.8;
  final double _jumpForce = 580;
  final double _terminalVelocity = 300;

  int hAxisInput = 0;

  bool hasJumped = false;
  bool isFaceRight = true;
  bool isFall = false;

  double horizontalMovement = 0;
  Vector2 velocity = Vector2.zero();
  Vector2 startingPosition = Vector2.zero();

  double fixedDeltaTime = 1 / 60;
  double accumulatedTime = 0;

  CustomHitbox hitbox = CustomHitbox(
    offsetX: 16,
    offsetY: 16,
    width: 32,
    height: 32,
  );

  double _dt = 0;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();

    size = Vector2(64, 64);

    startingPosition = Vector2(position.x, position.y);

    add(
      RectangleHitbox(
        position: Vector2(hitbox.offsetX, hitbox.offsetY),
        size: Vector2(hitbox.width, hitbox.height),
      ),
    );
    //debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _dt = dt;
    accumulatedTime += dt;

    while (accumulatedTime >= fixedDeltaTime) {
      _updatePlayerState();
      _applyGravity(fixedDeltaTime);

      velocity.x = hAxisInput * 400;
      position.x += velocity.x * dt;

      accumulatedTime -= fixedDeltaTime;
    }

    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) _playerJump(_dt);

    super.onCollisionStart(intersectionPoints, other);
  }

  void _loadAllAnimations() async {
    jumpingAnimation = _spriteAnimation('Jump', 1);
    fallingAnimation = _spriteAnimation('Fall', 1);
    hitAnimation = _spriteAnimation('Hit', 7)..loop = false;

    // List of all Animations
    animations = {
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
      PlayerState.hit: hitAnimation,
    };
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('character/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: _stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _playerJump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    hasJumped = false;
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.falling;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
      isFaceRight = false;
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
      isFaceRight = true;
    }

    if (velocity.y > 0) {
      playerState = PlayerState.falling;
      isFall = true;
    }

    if (velocity.y < 0) {
      playerState = PlayerState.jumping;
      isFall = false;
    }

    current = playerState;
  }

  moveRight() {
    hAxisInput = 0;
    hAxisInput += 1;
  }

  moveLeft() {
    hAxisInput = 0;
    hAxisInput -= 1;
  }
}

class CustomHitbox {
  final double offsetX;
  final double offsetY;
  final double width;
  final double height;

  CustomHitbox({
    required this.offsetX,
    required this.offsetY,
    required this.width,
    required this.height,
  });
}

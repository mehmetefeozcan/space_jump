import 'package:space_jump/game/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:math';

abstract class Platform<T> extends SpriteGroupComponent<T>
    with HasGameRef<MyGame>, CollisionCallbacks {
  // for collision
  final hitbox = RectangleHitbox(size: Vector2(100, 80));
  // horizontal move
  bool isMoving = false;

  final Vector2 velocity = Vector2.zero();
  double direction = 1;
  double speed = 35;

  Platform({
    super.position,
  }) : super(size: Vector2.all(100), priority: 2);

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    // add hitbox in game for the collision detection
    await add(hitbox);

    // for the some platform can move x axis
    final int rand = Random().nextInt(100);
    if (rand > 80) isMoving = true;
  }

  void _move(double dt) {
    // If move equals false, do nothing
    if (!isMoving) return;

    final double gameWidth = gameRef.size.x;

    if (position.x <= 0) {
      direction = 1;
    } else if (position.x >= gameWidth - size.x) {
      direction = -1;
    }

    velocity.x = direction * speed;

    position += velocity * dt;
  }

  @override
  void update(double dt) {
    _move(dt);
    super.update(dt);
  }
}

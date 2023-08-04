import 'package:flame/components.dart';
import 'package:space_jump/game/sprites/platform.dart';

enum NormalPlatformState { up, down }

class NormalPlatform extends Platform<NormalPlatformState> {
  NormalPlatform({super.position, required super.hitbox});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprites = <NormalPlatformState, Sprite>{
      NormalPlatformState.down: await gameRef.loadSprite('trampoline_down.png'),
      NormalPlatformState.up: await gameRef.loadSprite('trampoline_up.png'),
    };

    current = NormalPlatformState.up;

    // Sprite Size
    size = Vector2(80, 40);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    bool isCollidingVertically =
        (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;

    if (isCollidingVertically) {
      current = NormalPlatformState.down;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    current = NormalPlatformState.up;
  }
}

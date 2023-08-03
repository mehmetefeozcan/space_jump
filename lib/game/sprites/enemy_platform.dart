import 'package:flame/components.dart';
import 'package:space_jump/game/sprites/index.dart';

enum EnemyPlatformState { only }

class EnemyPlatform extends Platform<EnemyPlatformState> {
  EnemyPlatform({super.position});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    sprites = <EnemyPlatformState, Sprite>{
      EnemyPlatformState.only: await gameRef.loadSprite('character/ufo.png'),
    };

    current = EnemyPlatformState.only;

    size = Vector2(60, 40);
  }
}

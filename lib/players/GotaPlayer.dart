import 'package:flame/components.dart';
import 'package:ugh/game/UghGame.dart';

class GotaPlayer extends SpriteAnimationComponent with HasGameRef<UghGame> {
  GotaPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2(16,16),
        stepTime: 0.12,
      ),
    );
  }
}
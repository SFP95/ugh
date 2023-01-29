import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../game/UghGame.dart';

class StarElement extends SpriteAnimationComponent with HasGameRef<UghGame> {

  StarElement({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);


  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    /*final platformImage = game.images.fromCache('key.png');
    sprite = Sprite(platformImage);*/

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('key.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2(143,110),
        stepTime: 0.12,
      ),
    );
    add(RectangleHitbox()..collisionType = CollisionType.passive);

    //final Image spriteImage;
    //
  }
/*
  @override
  void update(double dt) {
    super.update(dt);

    if (game.health <= 0) {
      removeFromParent();
    }
  }*/
}
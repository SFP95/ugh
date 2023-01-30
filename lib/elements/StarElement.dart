import 'dart:html';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../game/UghGame.dart';


class StarBody extends BodyComponent<UghGame> with CollisionCallbacks{
  Vector2 tamWH;
  Vector2 posXY;

  StarBody({required this.tamWH,required this.posXY}):super();

    @override
    Body createBody() {
      // TODO: implement createBody
      //posXY.add(Vector2(0, -240));
      BodyDef bodyDef = BodyDef(
          type: BodyType.static,
          position: posXY,
          gravityOverride: Vector2(0,0),
          userData: this);
      Body cuerpo=world.createBody(bodyDef);
      CircleShape shape=CircleShape();
      shape.radius=tamWH.x/7;
      // userData: this, // To be able to determine object in collision
      cuerpo.createFixtureFromShape(shape);
      return cuerpo;
    }
  @override
  Future<void> onLoad() async{
    // TODO: implement onLoad
    renderBody=false;
    await super.onLoad();

    StarElement starElement=StarElement(position: Vector2.zero());
    add(starElement);
  }
}

class StarElement extends SpriteAnimationComponent with HasGameRef<UghGame> {

  StarElement({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.bottomLeft);


  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    animation = SpriteAnimation.fromFrameData(
        game.images.fromCache('key.png'),
    SpriteAnimationData.sequenced(
      amount: 2,
      textureSize: Vector2(143,110),
      stepTime: 0.12,
    )
    );

    //add(RectangleHitbox()..collisionType = CollisionType.passive);

    //final Image spriteImage;
    //
  }

}
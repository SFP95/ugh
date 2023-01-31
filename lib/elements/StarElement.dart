
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../game/UghGame.dart';


class StarBody extends BodyComponent<UghGame> with ContactCallbacks{
  Vector2 tamWH;
  Vector2 posXY;

  StarBody({required this.tamWH,required this.posXY}):super();

    @override
    Body createBody() {
      // TODO: implement createBody
      BodyDef bodyDef = BodyDef(
          type: BodyType.static,
          position: posXY,
          gravityOverride: Vector2(0,0),
          userData: this);
      Body cuerpo=world.createBody(bodyDef);
      CircleShape shape=CircleShape();
      shape.radius=tamWH.x/7;
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
  @override
  void update(double dt) {
    super.update(dt);

    if ( game.healthEmber <= 0 || game.healthEmber2 <= 0) {
      removeFromParent();
    }
  }
}

class StarElement extends SpriteAnimationComponent with HasGameRef<UghGame> {

  StarElement({required super.position})
      : super(size: Vector2.all(64), anchor: Anchor.center);


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

    // @override
    // void update(double dt) {
    //   super.update(dt);
    //
    //   if ( game.health <= 0) {
    //     removeFromParent();
    //   }
    // }
  }

}
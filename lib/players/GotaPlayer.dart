import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:ugh/game/UghGame.dart';


class GotaBody extends BodyComponent<UghGame>{

  Vector2 posxY;
  Vector2 tamWH;
  Vector2 xIni
  Vector2 xFin;
  Vector2 xContador;




  GotaBody({required this.posxY,required this.tamWH}):super();

  @override
  Body createBody() {
    BodyDef bodyDef = BodyDef(type: BodyType.dynamic, position: posxY);
    Body cuerpo= world.createBody(bodyDef);
    CircleShape shape= CircleShape();
    shape.radius=tamWH.x;
    cuerpo.createFixtureFromShape(shape);
    return world.createBody(bodyDef);

  }
  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();

    GotaPlayer gotaPlayer = GotaPlayer(position: Vector2.zero(),size: tamWH);
    add(gotaPlayer);
    xIni=posxY.x;
    xFin=(20);
    xContador=0;
  }
  @override
  void update(double dt) {
    super.update(dt);

    if(xContador>xFin){
      xContador=xContador-0.2;
      super.add(Vector2(xContador, 0));
    }
  }

}

class GotaPlayer extends SpriteAnimationComponent with HasGameRef<UghGame> {


  GotaPlayer({
    required super.position,required super.size,
  }) : super( anchor: Anchor.center);

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

    //movimiento del enemigo
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    add(
      MoveEffect.by(
        Vector2(-1 * size.x, 0),
        EffectController(
          duration: 3,
          alternate: true,
          infinite: true,
        ),
      ),
    );
  }
}
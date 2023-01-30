import 'dart:html';

import 'package:flame/collisions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../game/UghGame.dart';
import '../players/GotaPlayer.dart';

class GotaBody extends BodyComponent<UghGame> with CollisionCallbacks{
  Vector2 posXY;
  Vector2 tamWH;
  double xIni=0;
  double xFin=0;
  double xContador=0;
  double dAnimDireccion=-1;
  double dVelocidadAnim=1;

  GotaBody({required this.posXY,required this.tamWH}):super();

  @override
  Body createBody() {
    // TODO: implement createBody
    //posXY.add(Vector2(0, -240));
    BodyDef bodyDef = BodyDef(
        type: BodyType.dynamic,
        position: posXY,
        gravityOverride: Vector2(0,0),
        userData: this);
    Body cuerpo=world.createBody(bodyDef);
    CircleShape shape=CircleShape();
    shape.radius=tamWH.x/2;
    // userData: this, // To be able to determine object in collision
    cuerpo.createFixtureFromShape(shape);
    return cuerpo;
  }

  @override
  Future<void> onLoad() async{
    // TODO: implement onLoad
    renderBody=false;
    await super.onLoad();

    GotaPlayer gotaPlayer=GotaPlayer(position: Vector2.zero(), size: tamWH);
    add(gotaPlayer);

    xIni=posXY.x;
    xFin=(10);
    xContador=0;

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    //print("------------>>>>>>>>>>>>>> !!!!!! "+this.toString());
    //center.add(Vector2(-1,0));

    if(dAnimDireccion<0){
      xContador=xContador+dVelocidadAnim;
      center.sub(Vector2(dVelocidadAnim,0));
    }
    else{
      xContador=xContador+dVelocidadAnim;
      center.add(Vector2(dVelocidadAnim,0));
    }

    if(xContador>xFin){
      xContador=0;
      dAnimDireccion=dAnimDireccion*-1;
    }

  }


}
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ugh/game/UghGame.dart';

import '../elements/StarElement.dart';
import 'EmberPlayer.dart';
import 'GotaPlayer.dart';

class EmberBody2 extends BodyComponent<UghGame> with KeyboardHandler{

  Vector2 position;
  Vector2 size=Vector2(64, 64);
  late EmberPlayer emberPlayer2;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  double jumpSpeed=0;

  EmberBody2({required this.position});

  @override
  Future<void> onLoad() async{
    // TODO: implement onLoad
    await super.onLoad();
    emberPlayer2=EmberPlayer(position: Vector2.zero());
    emberPlayer2.size=size;
    add(emberPlayer2);
    renderBody=true;
  }

  @override
  Body createBody() {
    // TODO: implement createBody
    BodyDef definicionCuerpo= BodyDef(position: position,type: BodyType.dynamic);
    Body cuerpo= world.createBody(definicionCuerpo);

    final shape=CircleShape();
    shape.radius=size.x/2;

    FixtureDef fixtureDef=FixtureDef(
        shape,
        //density: 10.0,
        //friction: 0.2,
        restitution: 0.5
    );
    cuerpo.createFixture(fixtureDef);
    return cuerpo;
  }

  @override
  void onMount() {
    super.onMount();
    camera.followBodyComponent(this);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {

    horizontalDirection = 0;
    verticalDirection = 0;

    if((keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft))){
      horizontalDirection=-1;
    }
    else if((keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight))){
      horizontalDirection=1;
    }


    if((keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp))){
      verticalDirection=-1;
    }
    else if((keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown))){
      verticalDirection=1;
    }
    //game.setDirection(horizontalDirection,verticalDirection);
    return true;
  }

  @override
  void update(double dt) {

    velocity.x = horizontalDirection * moveSpeed;
    velocity.y = verticalDirection * moveSpeed;
    velocity.y += -1 * jumpSpeed;

    center.add((velocity * dt));

    if (horizontalDirection < 0 && emberPlayer2.scale.x > 0) {
      emberPlayer2.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && emberPlayer2.scale.x < 0) {
      emberPlayer2.flipHorizontallyAroundCenter();
    }

    if (position.x < -size.x || game.health <= 0) {
      game.setDirection(0,0);
      removeFromParent();

    }

    super.update(dt);
  }

}



class EmberPlayer2 extends SpriteAnimationComponent with HasGameRef<UghGame>,KeyboardHandler,CollisionCallbacks {

  EmberPlayer2({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  late CircleHitbox hitbox;
  bool hitByEnemy = false;

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(16,16),
        stepTime: 0.12,
      ),
    );

    //cuerpo para colisiones
    //.radius=size.x/2
    hitbox=CircleHitbox();
    add(hitbox);
  }


  //DETECCION DE COLISIONES


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    print("DEBUG: COLLISION EMBER-2!!!!!!! ");

    if (other is StarElement) {
      other.removeFromParent();
     // game.starsCollected++;
    }

    if (other is GotaPlayer) {
      hit();
    }

    if(other is EmberPlayer){
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    if (!hitByEnemy) {
      hitByEnemy = true;
      game.health--;
      add(
        OpacityEffect.fadeOut(
          EffectController(
            alternate: true,
            duration: 0.1,
            repeatCount: 6,
          ),
        )..onComplete = () {
          hitByEnemy = false;
        },
      );

    }
  }
}


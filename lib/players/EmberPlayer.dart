import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ugh/game/UghGame.dart';

class EmberPlayer extends SpriteAnimationComponent with HasGameRef<UghGame>,KeyboardHandler {

  int horizontalDirection = 0;
  int vertivalDirection = 0;

  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

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
  }
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    //print("DEBUG: ----------->>>>>>>> BOTON PRESIONADO: "+keysPressed.toString());
    horizontalDirection=0;
    vertivalDirection=0;

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
      vertivalDirection=-1;
    }
    else if((keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowDown))){
      vertivalDirection=1;
    }

    return true;
  }

  @override
  void update(double dt) {
    //position.add(Vector2(10.0*horizontalDirection, 0));
    velocity.x=horizontalDirection * moveSpeed;
    position += velocity * dt;
    super.update(dt);

    //cambiar dirección imagen de embar segun direccion
    if(horizontalDirection < 0 && scale.x > 0){
      flipHorizontally();
    }else if(horizontalDirection > 0 && scale.x < 0){
      flipHorizontally();
    }
  }
}


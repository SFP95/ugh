import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ugh/game/UghGame.dart';

class EmberPlayer extends SpriteAnimationComponent with HasGameRef<UghGame>,KeyboardHandler {

  int horizontalDirection=0;


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
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyB) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;
    return true;
  }

  @override
  void update(double dt) {
    position.add(Vector2(10, 0));
    super.update(dt);
  }
}


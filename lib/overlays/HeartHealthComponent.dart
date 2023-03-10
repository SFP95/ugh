import 'package:flame/components.dart';

import '../game/UghGame.dart';

enum HeartState {
  available,
  unavailable,
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState> with HasGameRef<UghGame> {
  final int heartNumber;
  final String nombreJugador;

  HeartHealthComponent({
    required this.nombreJugador,
    required this.heartNumber,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final availableSprite = await game.loadSprite(
      'health.png',
      srcSize: Vector2(260,207),
    );

    final unavailableSprite = await game.loadSprite(
      'health_half.png',
      srcSize: Vector2(260,207),
    );

    sprites = {
      HeartState.available: availableSprite,
      HeartState.unavailable: unavailableSprite,
    };

    current = HeartState.available;
  }

  @override
  void update(double dt) {
    if (nombreJugador=="Hormiga") {
      if (game.healthEmber< heartNumber) {
        current = HeartState.unavailable;
      } else {
        current = HeartState.available;
      }
    }else{
      if (game.healthEmber2 < heartNumber) {
        current = HeartState.unavailable;
      } else {
        current = HeartState.available;
      }
    }
    super.update(dt);
  }
}
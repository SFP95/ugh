import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ugh/players/EmberPlayer.dart';

class UghGame extends FlameGame{

  UghGame();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    TiledComponent mapComponent = await TiledComponent.load("mapa.tmx",Vector2(32,32));
    add(mapComponent);

    EmberPlayer emberPlayer = EmberPlayer(position: Vector2(300,300));
  }
}
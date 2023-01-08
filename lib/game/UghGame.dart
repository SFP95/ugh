import 'package:flame/game.dart';
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
    EmberPlayer emberPlayer = EmberPlayer(position: Vector2(300,300));
  }
}
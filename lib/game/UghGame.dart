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


   ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>("strellas");
   ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

//esto da error y pondría las estrellas y gotas en el mata donde correpsonde

   for (final estrella in estrellas!.objects){
     EmberPlayer estrellaComponent = EmberPlayer(position: Vector2(estrella.x,estrella.y));
         add(estrellaComponent);
         }
    for (final gota in gotas!.objects){
      EmberPlayer gotaComponent = EmberPlayer(position: Vector2(gota.x,gota.y));
      add(gotaComponent);
    }

    EmberPlayer emberPlayer = EmberPlayer(position: Vector2(300,300));
    add(emberPlayer);
  }
}
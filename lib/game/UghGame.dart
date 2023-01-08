import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ugh/elements/StarElement.dart';
import 'package:ugh/players/EmberPlayer.dart';
import 'package:ugh/players/GotaPlayer.dart';

class UghGame extends Forge2DGame with HasKeyboardHandlerComponents,HasCollisionDetection{
  late TiledComponent mapComponent;
  int verticalDirection = 0;
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  int starsCollected = 0;
  int health=3;
  List<PositionComponent>  objetosvisuales=[];
  late EmberBody _emberBody;

  UghGame():super(gravity: Vector2(0, 9.8),zoom: 0.75);;

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
     StarElement estrellaComponent = StarElement(position: Vector2(estrella.x,estrella.y));
      objetosvisuales.add(estrellaComponent);
         }
    for (final gota in gotas!.objects){
      GotaPlayer gotaComponent = GotaPlayer(position: Vector2(gota.x,gota.y));
      objetosvisuales.add(gotaComponent);
    }

    EmberPlayer emberPlayer = EmberPlayer(position: Vector2(300,300));
    add(emberPlayer);
  }
}
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ugh/elements/StarElement.dart';
import 'package:ugh/players/EmberPlayer.dart';
import 'package:ugh/players/GotaPlayer.dart';

import '../bodies/SueloBody.dart';
import '../overlays/hud.dart';
import '../players/EmberPlayer2.dart';
import '../ux/joypad.dart';

class UghGame extends Forge2DGame with HasKeyboardHandlerComponents,HasCollisionDetection{
  late TiledComponent mapComponent;
  int verticalDirection = 0;
  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  int starsCollected = 0;
  int health = 3;
  late EmberBody _emberBody;
  late EmberBody2 _emberBody2;

  List<PositionComponent>  objetosVisuales=[];

  UghGame():super(zoom: 1.1);

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

    //carcago de mapa
    mapComponent = await TiledComponent.load("mapa2.tmx", Vector2(32, 32));
    add(mapComponent);

  }

  //fondo de pantalla
  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  void setDirection(int horizontalDirection, int verticalDirection){
    this.horizontalDirection=horizontalDirection;
    this.verticalDirection=verticalDirection;
  }

  void initializeGame (bool loadHud) async{
    objetosVisuales.clear();
    mapComponent.position=Vector2(0, 0);

    //cargado de gotas enemigos y objetos estrella + initplayer
    ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");
    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");
    ObjectGroup? posinitplayer = mapComponent.tileMap.getLayer<ObjectGroup>("posinitplayer");
    ObjectGroup? posinitplayer2 = mapComponent.tileMap.getLayer<ObjectGroup>("posinitplayer2");
    ObjectGroup? suelos = mapComponent.tileMap.getLayer<ObjectGroup>("suelos");

    for(final suelo in suelos!.objects){
      SueloBody body=SueloBody(tiledBody: suelo);
      add(body);
    }

    // posición de los enemigos y estrellas
    for (final estrella in estrellas!.objects) {
      StarElement estrellaComponent = StarElement(
          position: Vector2(estrella.x, estrella.y));
      objetosVisuales.add(estrellaComponent);
      add(estrellaComponent);
    }

    for (final gota in gotas!.objects) {
      GotaBody gotaComponent = GotaBody(posxY: Vector2(gota.x-1, gota.y));
      //objetosVisuales.add(gotaComponent);
      add(gotaComponent);
    }

    //cargado de jugador ember ( que se mueve con los botones: A, W, D, S) y ember 2 ( que se mueve con los botones: J, I, L, K)
    _emberBody= EmberBody(position: Vector2(posinitplayer!.objects.first.x,posinitplayer!.objects.first.y));
    add(_emberBody);
    // EmberPlayer emberPlayer= EmberPlayer(position: Vector2(posinitplayer!.objects.first.x,posinitplayer!.objects.first.y));
    // add(emberPlayer);


    _emberBody2= EmberBody2(position: Vector2(posinitplayer2!.objects.first.x,posinitplayer!.objects.first.y));
    add(_emberBody2);
    // EmberPlayer2 emberPlayer2= EmberPlayer2(position: Vector2(posinitplayer2!.objects.first.x,posinitplayer!.objects.first.y));
    // add(emberPlayer2);

    if(loadHud){
      add(Hud());
    }
  }

  void reset(){
    starsCollected=0;
    health=3;
    initializeGame(false);
  }

  void joypadMoved(Direction direction){
    //print("JOYPAD EN MOVIMIENTO:   ---->  "+direction.toString());

    horizontalDirection=0;
    verticalDirection=0;

    if(direction==Direction.left){
      horizontalDirection=-1;
    }
    else if(direction==Direction.right){
      horizontalDirection=1;
    }


    if(direction==Direction.up){
      verticalDirection=-1;
    }
    else if(direction==Direction.down){
      verticalDirection=1;
    }

    //_emberBody.horizontalDirection=horizontalDirection;
    //_emberBody2.horizontalDirection=horizontalDirection;
  }

}
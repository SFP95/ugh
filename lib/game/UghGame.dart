import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ugh/elements/StarElement.dart';
import 'package:ugh/players/EmberPlayer.dart';
import 'package:ugh/players/GotaPlayer.dart';

import '../bodies/GotaBody.dart';
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
  int starsCollectedEmber = 0;
  int starsCollectedEmber2 = 0;
  int healthEmber = 3;
  int healthEmber2 = 3;
  late EmberBody _emberBody;
  late EmberBody2 _emberBody2;

  List<Component> objetosVisuales = [];
  UghGame():super(zoom: 1.1);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await images.loadAll([
      'demonio.png',
      'hormiga.png',
      'key.png',
      'goldenkey.png',
      'health.png',
      'health_half.png',
      'angrybird.png'
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


  //Cuando la vida lleva a cero el juego acaba
  @override
  void update(double dt) {
    if (healthEmber<=0 || healthEmber2<=0){
      overlays.add("GameOver");
    }
    super. update(dt);
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


    //incluimos los suelos
    for(final suelo in suelos!.objects){
      SueloBody body=SueloBody(tiledBody: suelo);
      add(body);
    }

    // posici??n de los enemigos y estrellas
    for (final estrella in estrellas!.objects) {
      StarBody estrellaComponent = StarBody(
          posXY: Vector2(estrella.x, estrella.y), tamWH: Vector2(143,110));
      // objetosVisuales.add(estrellaComponent);
      add(estrellaComponent);
    }

    for (final gota in gotas!.objects) {
      GotaBody gotaComponent = GotaBody(posXY: Vector2(gota.x-1, gota.y),tamWH: Vector2(64,64));
      //objetosVisuales.add(gotaComponent);
      add(gotaComponent);
    }

    //cargado de jugador ember ( que se mueve con los botones: A, W, D, S) y ember 2 ( que se mueve con los botones: J, I, L, K)
    _emberBody= EmberBody(position: Vector2(posinitplayer!.objects.first.x,posinitplayer!.objects.first.y));
    add(_emberBody);
    // EmberPlayer emberPlayer= EmberPlayer(position: Vector2(posinitplayer!.objects.first.x,posinitplayer!.objects.first.y));
    // add(emberPlayer);
    objetosVisuales.add(_emberBody);



    _emberBody2= EmberBody2(position: Vector2(posinitplayer2!.objects.first.x,posinitplayer!.objects.first.y));
    add(_emberBody2);
    // EmberPlayer2 emberPlayer2= EmberPlayer2(position: Vector2(posinitplayer2!.objects.first.x,posinitplayer!.objects.first.y));
    // add(emberPlayer2);
    objetosVisuales.add(_emberBody2);




    if(loadHud){
      add(Hud(nombreJu: "Hormiga",posYCorazon: 40,posYStrella: 20,posYContador: 20,posYJugador: 20));
      add(Hud(nombreJu: "Demonio",posYCorazon: 110,posYStrella: 60,posYContador: 60,posYJugador: 90));

    }
  }

  void reset(){
    starsCollectedEmber=0;
    starsCollectedEmber2=0;
    healthEmber=3;
    healthEmber2=3;
    /*for(Component comp in objetosVisuales){
      remove(comp);
    }
    objetosVisuales.clear();*/
    initializeGame(false);
  }



  // PARA PODER MOVERLO CON EL JOYPAD

  // void joypadMoved(Direction direction){
  //   //print("JOYPAD EN MOVIMIENTO:   ---->  "+direction.toString());
  //
  //   horizontalDirection=0;
  //   verticalDirection=0;
  //
  //   if(direction==Direction.left){
  //     horizontalDirection=-1;
  //   }
  //   else if(direction==Direction.right){
  //     horizontalDirection=1;
  //   }
  //
  //
  //   if(direction==Direction.up){
  //     verticalDirection=-1;
  //   }
  //   else if(direction==Direction.down){
  //     verticalDirection=1;
  //   }
  //
  //   //_emberBody.horizontalDirection=horizontalDirection;
  //   //_emberBody2.horizontalDirection=horizontalDirection;
  // }

}
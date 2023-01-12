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
import '../players/EmberPlayer2.dart';

class UghGame extends Forge2DGame with HasKeyboardHandlerComponents,HasCollisionDetection{

  List<PositionComponent>  objetosVisuales=[];


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
    TiledComponent mapComponent = await TiledComponent.load(
        "mapa2.tmx", Vector2(32, 32));
    add(mapComponent);


    //cargado de gotas enemigos y objetos estrella + initplayer
    ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>(
        "estrellas");
    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");
    ObjectGroup? posinitplayer = mapComponent.tileMap.getLayer<ObjectGroup>("posinitplayer");
    ObjectGroup? posinitplayer2 = mapComponent.tileMap.getLayer<ObjectGroup>("posinitplayer2");

    // posición de los enemigos y estrellas
    for (final estrella in estrellas!.objects) {
      StarElement estrellaComponent = StarElement(
          position: Vector2(estrella.x, estrella.y));
      objetosVisuales.add(estrellaComponent);
      add(estrellaComponent);
    }

    for (final gota in gotas!.objects) {
      GotaPlayer gotaComponent = GotaPlayer(position: Vector2(gota.x-1, gota.y));
      objetosVisuales.add(gotaComponent);
      add(gotaComponent);
    }
    //cargado de jugador ember ( que se mueve con los botones: A, W, D, S) y ember 2 ( que se mueve con los botones: J, I, L, K)
    EmberPlayer emberPlayer= EmberPlayer(position: Vector2(posinitplayer!.objects.first.x,posinitplayer!.objects.first.y));
    add(emberPlayer);

    EmberPlayer2 emberPlayer2= EmberPlayer2(position: Vector2(posinitplayer2!.objects.first.x,posinitplayer!.objects.first.y));
    add(emberPlayer2);

  }
  //fondo de pantalla
  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }
}
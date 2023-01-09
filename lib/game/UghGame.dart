import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:ugh/elements/StarElement.dart';
import 'package:ugh/players/EmberPlayer.dart';
import 'package:ugh/players/GotaPlayer.dart';

import '../bodies/SueloBody.dart';

class UghGame extends FlameGame with HasKeyboardHandlerComponents,HasCollisionDetection{

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

    TiledComponent mapComponent = await TiledComponent.load(
        "mapa.tmx", Vector2(32, 32));
    add(mapComponent);
    ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>(
        "estrellas");
    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    @override
    Color backgroundColor() {
      return const Color.fromARGB(255, 173, 223, 247);
    }


    for (final estrella in estrellas!.objects) {
      //print("DEBUG: ----->>>>  "+estrella.x.toString()+"    "+estrella.y.toString());
      //EmberPlayer estrellaComponent = EmberPlayer(position: Vector2(estrella.x,estrella.y));
      StarElement estrellaComponent = StarElement(
          position: Vector2(estrella.x, estrella.y));
      objetosVisuales.add(estrellaComponent);
      add(estrellaComponent);
    }

    for (final gota in gotas!.objects) {
      //print("DEBUG: ----->>>>  "+estrella.x.toString()+"    "+estrella.y.toString());
      GotaPlayer gotaComponent = GotaPlayer(position: Vector2(gota.x, gota.y));
      objetosVisuales.add(gotaComponent);
      add(gotaComponent);
    }
  }
}
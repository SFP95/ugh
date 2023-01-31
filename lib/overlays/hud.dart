import 'dart:ui';
import 'package:flame/components.dart';
import '../game/UghGame.dart';
import 'package:flutter/material.dart';
import 'HeartHealthComponent.dart';

class Hud extends PositionComponent with HasGameRef<UghGame> {

  late String nombreJu;
  late double posYCorazon;
  late double posYStrella;
  late double posYContador;
  late double posYJugador;

  int starColected=0;
  int healthPlayer=3;

  Hud({
    required this.nombreJu,
    required this.posYCorazon,
    required this.posYStrella,
    required this.posYContador,
    required this.posYJugador,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  }) {
    positionType = PositionType.viewport;
  }

  late TextComponent _scoreTextComponent;
  late TextComponent nombreJugadorTx;

  @override
  Future<void>? onLoad() async {
    _scoreTextComponent = TextComponent(
      text: '${starColected}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 20),
    );
    add(_scoreTextComponent);

    nombreJugadorTx= TextComponent(
      text: nombreJu,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 32,
          color: Colors.black
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(60,posYJugador),
    );
    add(nombreJugadorTx);


    //contador llaves

    final starSprite = await game.loadSprite('goldenkey.png');
    add(
      SpriteComponent(
        sprite: starSprite,
        position: Vector2(game.size.x - 100, posYStrella),
        size: Vector2(70,54),
        anchor: Anchor.center,
      ),
    );

    int posicionX=150;

    //contador vidas

    for (var i = 1; i <= healthPlayer; i++) {
      final positionX = 40 * i;
      await add(
        HeartHealthComponent(
          heartNumber: i,
          position: Vector2(positionX.toDouble(), posYCorazon),
          size: Vector2.all(32),
          nombreJugador:nombreJu,
        ),
      );
      posicionX+=50;
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {

    if(nombreJu=="Hormiga") {
      starColected= game.starsCollectedEmber;
    }else{
      starColected= game.starsCollectedEmber2;
    }

        _scoreTextComponent.text = '${starColected}';

    super.update(dt);
    }
  }

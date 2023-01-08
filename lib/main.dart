import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/UghGame.dart';

void main() {

  runApp(
    const GameWidget<UghGame>.controlled(
      gameFactory: UghGame.new,
    ),
  );
  /**
   * final game = UghGame();
      runApp(GameWidget(game: game));
    */

}

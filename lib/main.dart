import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/UghGame.dart';

void main() {
  final game = UghGame();
  runApp(GameWidget(game: game));
}

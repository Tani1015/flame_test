import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:game_test/game/managers/game_manager.dart';
import 'package:game_test/game/managers/level_manager.dart';

enum Character { men, women }

class DoodleDash extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  DoodleDash({super.children});

  final World _world = World();
  LevelManager levelManager = LevelManager();
  GameManager gameManager = GameManager();
  int screenBufferSpace = 300;

  @override
  FutureOr<void> onLoad() async {
    await add(_world);
  }
}

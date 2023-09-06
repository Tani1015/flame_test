import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:game_test/game/doodle_dash.dart';

enum PlayerState {
  left,
  right,
  center,
  rocket,
  nooglerCenter,
  nooglerLeft,
  nooglerRight
}

class Player extends SpriteGroupComponent<PlayerState>
    with HasGameRef<DoodleDash>, KeyboardHandler, CollisionCallbacks {
  Player({
    super.position,
    required this.character,
  });

  Character character;

  // キャラクターの現在地
  int hAxisInput = 0;
  // キャラクターの左への移動距離
  final int movingLeftInput = -1;
  // キャラクターの右げの移動距離
  final int movingRightInput = 1;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    await _loadCharacterSprites();
    current = PlayerState.center;
  }

  void moveLeft() {
    hAxisInput = 0;

    current = PlayerState.left;

    hAxisInput += movingLeftInput;
  }

  void moveRight() {
    hAxisInput = 0;

    current = PlayerState.right;

    hAxisInput += movingRightInput;
  }

  void jump() {
    hAxisInput = 0;

    current = PlayerState.center;
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    hAxisInput = 0;

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      moveRight();
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      moveLeft();
    }

    // if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
    // jump()
    // }

    return true;
  }

  Future<void> _loadCharacterSprites() async {
    final left = await gameRef.loadSprite('game/${character.name}_left.png');
    final right = await gameRef.loadSprite('game/${character.name}_right.png');
    final center =
        await gameRef.loadSprite('game/${character.name}_center.png');
    final rocket = await gameRef.loadSprite('game/rocket_4.png');
    final nooglerCenter =
        await gameRef.loadSprite('game/${character.name}_hat_center.png');
    final nooglerLeft =
        await gameRef.loadSprite('game/${character.name}_hat_left.png');
    final nooglerRight =
        await gameRef.loadSprite('game/${character.name}_hat_right.png');

    sprites = <PlayerState, Sprite>{
      PlayerState.left: left,
      PlayerState.right: right,
      PlayerState.center: center,
      PlayerState.rocket: rocket,
      PlayerState.nooglerCenter: nooglerCenter,
      PlayerState.nooglerLeft: nooglerLeft,
      PlayerState.nooglerRight: nooglerRight,
    };
  }
}

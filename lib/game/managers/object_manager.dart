import 'dart:math';

import 'package:flame/components.dart';
import 'package:game_test/game/doodle_dash.dart';
import 'package:game_test/game/sprites/platform.dart';
import 'package:game_test/game/util/num_utils.dart';

final Random _random = Random();

class ObjectManager extends Component with HasGameRef<DoodleDash> {
  ObjectManager({
    this.minVerticalDistanceToNextPlatform = 200,
    this.maxVerticalDistanceToNextPlatform = 300,
  });

  double minVerticalDistanceToNextPlatform;
  double maxVerticalDistanceToNextPlatform;
  // 確率を生成 1/100
  final probGen = ProbabilityGenerator();
  final double tallestPlatformHeight = 50;
  final List<Platform> platforms = [];

  // 生成するオブジェクトを定義
  final Map<String, bool> specialPlatforms = {
    'spring': true,
    'broken': false,
    'noogler': false,
    'locket': false,
    'enemy': false,
  };

  void cleanUpPlatform() {
    final lowestPlat = platforms.removeAt(0);

    lowestPlat.removeFromParent();
  }

  void enableSpecialty(String specialty) => specialPlatforms[specialty] = true;

  void resetSpecialties() {
    for (final key in specialPlatforms.keys) {
      specialPlatforms[key] = false;
    }
  }
}

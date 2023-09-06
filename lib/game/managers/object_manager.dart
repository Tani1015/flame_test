import 'dart:math';

import 'package:flame/components.dart';
import 'package:game_test/game/doodle_dash.dart';
import 'package:game_test/game/managers/level_manager.dart';
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

  void enableLevelSpecialty(int level) {
    // レベルごとに specialPlatforms で生成されるオブジェクトを決める
  }

  void resetSpecialties() {
    for (final key in specialPlatforms.keys) {
      specialPlatforms[key] = false;
    }
  }

  void configure(int nextLevel, Difficulty config) {
    minVerticalDistanceToNextPlatform = gameRef.levelManager.minDistance;
    maxVerticalDistanceToNextPlatform = gameRef.levelManager.maxDistance;

    for (var i = 0; i <= nextLevel; i++) {
      enableLevelSpecialty(i);
    }
  }

  double generateNextX(int platformWidth) {
    final previousPlatformXRange = Range(
      platforms.last.position.x,
      platforms.last.position.x + platformWidth,
    );

    double nextPlatformAnchorX;

    do {
      // 次の生成するオブジェクトのX座標をランダムで決定する。
      nextPlatformAnchorX =
          _random.nextInt(gameRef.size.x.floor() - platformWidth).toDouble();
      // ランダムで決められたオブジェクトの幅が前のオブジェクトのX座標と被っていないかを判定
    } while (previousPlatformXRange.overlaps(
      Range(
        nextPlatformAnchorX,
        nextPlatformAnchorX + platformWidth,
      ),
    ));
    return nextPlatformAnchorX;
  }

  double generateNextY() {
    final currentHighestPlatformY =
        platforms.last.center.y + tallestPlatformHeight;

    // 前のオブジェクトからとる最低距離 +  生成する距離のランダム値 (200 ~ 300)
    final distanceToNextY = minVerticalDistanceToNextPlatform.toInt() +
        _random
            .nextInt(
              // 0 ~ 100
              (maxVerticalDistanceToNextPlatform -
                      minVerticalDistanceToNextPlatform)
                  .floor(),
            )
            .toDouble();
    // 画面上では左上が(x,y):(0,0)なので減算する。
    return currentHighestPlatformY - distanceToNextY;
  }
}

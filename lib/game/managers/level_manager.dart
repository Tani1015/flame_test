import 'package:flame/components.dart';
import 'package:game_test/game/doodle_dash.dart';

// 難易度
class Difficulty {
  final double minDistance;
  final double maxDistance;
  final double jumpSpeed;
  final int score;

  const Difficulty({
    required this.minDistance,
    required this.maxDistance,
    required this.jumpSpeed,
    required this.score,
  });
}

class LevelManager extends Component with HasGameRef<DoodleDash> {
  LevelManager({this.selectedLevel = 1, this.level = 1});

  int selectedLevel;
  int level;

  final Map<int, Difficulty> levelsConfig = {
    1: const Difficulty(
        minDistance: 200, maxDistance: 300, jumpSpeed: 600, score: 0),
    2: const Difficulty(
        minDistance: 200, maxDistance: 400, jumpSpeed: 650, score: 20),
    3: const Difficulty(
        minDistance: 200, maxDistance: 500, jumpSpeed: 700, score: 40),
    4: const Difficulty(
        minDistance: 200, maxDistance: 600, jumpSpeed: 750, score: 80),
    5: const Difficulty(
        minDistance: 200, maxDistance: 700, jumpSpeed: 800, score: 100),
  };

  double get minDistance => levelsConfig[level]!.minDistance;
  double get maxDistance => levelsConfig[level]!.maxDistance;
  double get startingJumpSpeed => levelsConfig[selectedLevel]!.jumpSpeed;
  double get jumpSpeed => levelsConfig[level]!.jumpSpeed;
  Difficulty get difficulty => levelsConfig[level]!;
  List<int> get levels => levelsConfig.keys.toList();

  bool shouldLevelUp(int score) {
    int nextLevel = level + 1;

    if (levelsConfig.containsKey(nextLevel)) {
      return levelsConfig[nextLevel]!.score == score;
    }
    return false;
  }

  void increaseLevel() {
    if (level < levelsConfig.keys.length) {
      level++;
    }
  }

  void setLevel({required int newLevel}) {
    if (levelsConfig.containsKey(newLevel)) {
      level = newLevel;
    }
  }

  void selectLevel({required int selectLevel}) {
    if (levelsConfig.containsKey(selectLevel)) {
      selectedLevel = selectLevel;
    }
  }

  void reset() => level = selectedLevel;
}

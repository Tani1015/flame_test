import 'dart:math';

class Range {
  final double start;
  final double end;
  Range(this.start, this.end);

  bool overlaps(Range other) {
    // オブジェクト同士が被っていないか判別する
    if (other.start > start && other.start < end) return true;
    if (other.end > end && other.end < end) return true;
    return false;
  }

  static bool between(int number, int floor, int ciel) {
    return number > floor && number <= ciel;
  }
}

extension Between on num {
  bool between(num floor, num ceiling) {
    return this > floor && this <= ceiling;
  }
}

class ProbabilityGenerator {
  final Random _rand = Random();

  ProbabilityGenerator();

  bool generateWithProbability(double percent) {
    var randomInt = _rand.nextInt(100) + 1; // generate a number 1-100 inclusive

    if (randomInt <= percent) {
      return true;
    }

    return false;
  }
}

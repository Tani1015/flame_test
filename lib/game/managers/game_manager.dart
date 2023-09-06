import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:game_test/game/doodle_dash.dart';

enum GameState { intro, playing, gameOver }

class GameManager extends Component with HasGameRef<DoodleDash> {
  GameManager();

  Character character = Character.men;
  ValueNotifier<int> score = ValueNotifier<int>(0);
  GameState state = GameState.intro;

  bool get isGameOver => state == GameState.gameOver;
  bool get isPlaying => state == GameState.intro;
  bool get isIntro => state == GameState.intro;

  void reset() {
    score.value = 0;
    state = GameState.intro;
  }

  void increaseScore() => score.value++;

  void selectCharacter(Character selectedCharacter) =>
      character = selectedCharacter;
}

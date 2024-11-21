import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:seminar_game/game/assets.dart';
import 'package:seminar_game/game/flappy_bird_game.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame>{

  @override
  FutureOr<void> onLoad() async {
    final background = await Flame.images.load(Assets.backgorund);
    size = gameRef.size;
    sprite = Sprite(background);
    return super.onLoad();
  }

}
import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:seminar_game/components/pipe.dart';
import 'package:seminar_game/game/configuration.dart';
import 'package:seminar_game/game/flappy_bird_game.dart';
import 'package:seminar_game/game/pipe_position.dart';

import '../game/assets.dart';

class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  final _random = Random();
  @override
  FutureOr<void> onLoad() {
    position.x = gameRef.size.x;
    final heightMinusGround = gameRef.size.y - Config.groundHeight;
    final spacing =  100 + _random.nextDouble() * (heightMinusGround/4);
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);
    addAll([Pipe(height: centerY - spacing /2, pipePosition: PipePosition.top)]);
    addAll([Pipe(height: heightMinusGround - (centerY + spacing/2), pipePosition: PipePosition.bottom)]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= Config.gameSpeed * dt;

    if(position.x < -10){
      removeFromParent();
      updateScore();
    }

    if(gameRef.isHit){
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore(){
    gameRef.bird.score++;
    FlameAudio.play(Assets.point);
  }

}





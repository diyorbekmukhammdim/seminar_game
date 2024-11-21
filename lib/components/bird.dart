import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import 'package:seminar_game/game/assets.dart';
import 'package:seminar_game/game/bird_movement.dart';
import 'package:seminar_game/game/configuration.dart';
import 'package:seminar_game/game/flappy_bird_game.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>,CollisionCallbacks {
  int score = 0;
  @override
  FutureOr<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap
    };
    current = BirdMovement.middle;
    add(CircleHitbox());
    return super.onLoad();
  }

  void fly() {
    add(MoveByEffect(Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate), onComplete: ()=> current = BirdMovement.down));
    current = BirdMovement.up;
    FlameAudio.play(Assets.flying);
  }
@override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

  void gameOver(){
    FlameAudio.play(Assets.collision);
    gameRef.overlays.add('gameOver');
    game.isHit = true;
    gameRef.pauseEngine();
  }

  void reset(){
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }
  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if(position.y < 1){
      gameOver();
    }
  }
}

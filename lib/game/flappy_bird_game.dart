import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:seminar_game/components/background.dart';
import 'package:seminar_game/components/bird.dart';
import 'package:seminar_game/components/ground.dart';
import 'package:seminar_game/components/pipe_group.dart';
import 'package:seminar_game/game/configuration.dart';

class FlappyBirdGame extends FlameGame with TapDetector,HasCollisionDetection {

  late Bird bird;
  late TextComponent score;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;

  @override
  FutureOr<void> onLoad() {
    addAll([Background(), Ground(), bird = Bird(),score = buildScore()]);
    interval.onTick = () => add(PipeGroup());
    return super.onLoad();
  }
  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }
  TextComponent buildScore(){
    return TextComponent(
        text: 'Score:0',
        position: Vector2(size.x/2, size.y/2*0.2),
      anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
        )
    );
  }
  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }
}
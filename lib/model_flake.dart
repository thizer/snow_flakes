import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:simple_animations/simple_animations.dart';

class ModelFlake {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random = Random();

  ModelFlake() {
    restart();
  }

  void restart({Duration time = Duration.zero}) {
    final screenSize = Size(400.0, 600.0);

    double initPosX = this.random.nextInt(screenSize.width.toInt()).toDouble();
    double initPosY = this.random.nextInt(screenSize.height.toInt()).toDouble();
    double endPosY = initPosY + ((this.random.nextInt(100) + 30) * this.random.nextDouble());

    if (this.random.nextBool()) {
      endPosY = initPosY - (endPosY - initPosY);
    }

    final startPosition = Offset(initPosX / 2, initPosY);
    final endPosition = Offset(initPosX * 4, endPosY);
    final duration = Duration(milliseconds: 3000 + this.random.nextInt(6000));

    // Movimentos
    this.tween = MultiTrackTween([
      Track("x").add(
        duration,
        Tween(begin: startPosition.dx, end: endPosition.dx),
        curve: Curves.slowMiddle,
      ),
      Track("y").add(
        duration,
        Tween(begin: startPosition.dy, end: endPosition.dy),
        curve: Curves.easeIn,
      ),
    ]);

    // Progresso da animacao
    this.animationProgress = AnimationProgress(
      duration: duration,
      startTime: time,
    );

    // Define um numero randomico para o tamanho
    this.size = this.random.nextInt(5).toDouble();
    if (this.size < 1) {
      this.size = 1;
    }
  }

  void maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1) {
      restart(time: time);
    }
  }
}

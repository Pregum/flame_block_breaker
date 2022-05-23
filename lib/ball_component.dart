import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BallComponent extends PositionComponent with CollisionCallbacks {
  double speedY = -5;
  double speedX = 5;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    await add(
      CircleHitbox(
        radius: 5.0,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += Vector2(speedX, speedY);
  }

  void reverseX() {
    speedX = -speedX;
  }

  void reverseY() {
    speedY = -speedY;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      Offset.zero,
      5.0,
      Paint()..color = Colors.white,
    );
  }
}

import 'package:first_flame_block_breaker/ball_component.dart';
import 'package:first_flame_block_breaker/wall_component.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerComponent extends RectangleComponent with CollisionCallbacks {
  double speed = 5;
  bool movingLeft = false;
  bool movingRight = false;

  PlayerComponent(
      {super.anchor,
      super.angle,
      super.children,
      super.position,
      super.priority,
      super.size});

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += movingLeft ? -speed : 0;
    position.x += movingRight ? speed : 0;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is WallComponent) {
      movingLeft = false;
      movingRight = false;
    } else if (other is BallComponent) {
      other.reverseY();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      toRect(),
      Paint()..color = Colors.white,
    );
  }
}

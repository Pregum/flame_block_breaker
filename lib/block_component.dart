import 'package:first_flame_block_breaker/ball_component.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BlockComponent extends RectangleComponent with CollisionCallbacks {
  BlockComponent({
    super.anchor,
    super.angle,
    super.children,
    super.position,
    super.priority,
    super.size,
  });
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is BallComponent) {
      removeFromParent();
      other.reverseY();
    }
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }

  @override
  render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(toRect(), Paint()..color = Colors.white);
  }
}

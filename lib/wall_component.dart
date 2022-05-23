import 'package:first_flame_block_breaker/ball_component.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class WallComponent extends PositionComponent with CollisionCallbacks {
  final WallAnchor wallAnchor;

  WallComponent({
    super.anchor,
    super.angle,
    super.children,
    super.position,
    super.priority,
    super.scale,
    super.size,
    required this.wallAnchor,
  });

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      toRect(),
      Paint()..color = Colors.white,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is BallComponent) {
      if (wallAnchor == WallAnchor.left || wallAnchor == WallAnchor.right) {
        other.reverseX();
      } else if (wallAnchor == WallAnchor.top ||
          wallAnchor == WallAnchor.bottom) {
        other.reverseY();
      }
    }
  }
}

enum WallAnchor {
  top,
  left,
  right,
  bottom,
}

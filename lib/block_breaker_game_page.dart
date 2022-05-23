import 'package:first_flame_block_breaker/ball_component.dart';
import 'package:first_flame_block_breaker/block_component.dart';
import 'package:first_flame_block_breaker/player_component.dart';
import 'package:first_flame_block_breaker/wall_component.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BlockBreakerGamePage extends FlameGame
    with HasCollisionDetection, HasTappables, KeyboardEvents {
  final rowLength = 2;
  final columnLength = 4;

  bool isStart = false;
  late PlayerComponent player;
  late BallComponent ball;
  @override
  Future<void>? onLoad() async {
    // await super.onLoad();
    // TODO: ここに読み込むデータなどを記載する

    // await add(TextComponent(text: 'hello world')
    //   ..position = Vector2(100, 100)
    //   ..size = Vector2(100, 100)
    //   ..debugMode = true);
    await _prepareScene();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      player.movingLeft = true;
      player.movingRight = false;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      player.movingLeft = false;
      player.movingRight = true;
    } else {
      player.movingLeft = false;
      player.movingRight = false;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void refresh() {
    ball.removeFromParent();
    add(ball = BallComponent()
      ..topLeftPosition = size.clone()
      ..x /= 2
      ..y *= 0.65);
  }

  // @override
  // void onGameResize(Vector2 canvasSize) {
  //   super.onGameResize(canvasSize);
  // }

  Future<void> _prepareScene() async {
    final palyerPosition = size.clone()
      ..y *= 0.85
      ..x /= 2;
    await add(player =
        PlayerComponent(position: palyerPosition, size: Vector2(size.x / 5, 20))
          ..debugMode = true);
    final wallSize = size.clone()..x = 15;
    await add(
      WallComponent(
          wallAnchor: WallAnchor.left, position: Vector2.zero(), size: wallSize)
        ..debugMode = true,
    );
    final rightPos = size.clone()..y = 0;
    await add(
      WallComponent(
          wallAnchor: WallAnchor.right, position: rightPos, size: wallSize),
    );
    final topWallSize = size.clone()..y = 15;
    await add(
      WallComponent(
          wallAnchor: WallAnchor.top,
          position: Vector2.zero(),
          size: topWallSize),
    );
    add(ball = BallComponent()
      ..topLeftPosition = size.clone()
      ..x /= 2
      ..y *= 0.65
      ..debugMode = true);
    _prepareBlocks();

    // add(ButtonComponent(
    //     button: TextComponent(text: 'start!'),
    //     onPressed: () {
    //       isStart = true;
    //     })
    //   ..position = size.clone()
    //   ..y /= 2
    //   ..x /= 4);
  }

  @override
  void update(double dt) {
    if (!isStart) {
      return;
    }
    super.update(dt);
  }

  Future<void> _prepareBlocks() async {
    final oneBlockSize = size.clone()
      ..y /= (4 * rowLength)
      ..x /= (columnLength);
    for (var i = 0; i < rowLength; i++) {
      final top = oneBlockSize.y * i;
      for (var j = 0; j < columnLength; j++) {
        final left = oneBlockSize.x * j;
        await add(
          BlockComponent(
            size: oneBlockSize,
            position: Vector2(
              left,
              top,
            ),
          )..debugMode = true,
        );
      }
    }
  }
}

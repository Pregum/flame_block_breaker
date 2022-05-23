import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'block_breaker_game_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  BlockBreakerGamePage game = BlockBreakerGamePage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ゲームエリア')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!game.isStart) {
              game.isStart = true;
            } else {
              game.refresh();
            }
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          color: Colors.white,
          child: GameWidget(
            game: game,
          ),
        ),
      ),
    );
    // return GameWidget(game: BlockBreakerGamePage());
  }
}

import 'package:space_jump/game/views/index.dart';
import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class GameView extends StatefulWidget {
  const GameView(this.game, {super.key});

  final Game game;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    MyGame game = widget.game as MyGame;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          game.gameManager.isIntro
              ? const SizedBox()
              : Positioned(
                  top: 30,
                  left: 30,
                  child: ScoreDisplay(game: game),
                ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    game.player.moveLeft();
                  },
                  onTapUp: (details) {
                    game.player.resetDirection();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) {
                    game.player.moveRight();
                  },
                  onTapUp: (details) {
                    game.player.resetDirection();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:space_jump/game/widgets/index.dart';
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
      child: SafeArea(
        child: Stack(
          children: [
            game.gameManager.isPlaying
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomCompleteBar(
                      value: game.gameManager.gamePercent,
                    ),
                  )
                : const SizedBox(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                game.gameManager.isMain
                    ? const SizedBox()
                    : ScoreDisplay(game: game),
                game.gameManager.isPlaying
                    ? InkWell(
                        onTap: () => game.pauseGame(),
                        child: const Icon(Icons.pause,
                            color: Colors.white, size: 48),
                      )
                    : const SizedBox()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

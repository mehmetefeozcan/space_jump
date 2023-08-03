import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_jump/game/game.dart';

class MenuView extends StatefulWidget {
  const MenuView(this.game, {super.key});

  final Game game;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    MyGame game = widget.game as MyGame;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                game.startGame();
              },
              child: const Icon(
                Icons.play_arrow,
                size: 64,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

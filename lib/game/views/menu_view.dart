import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class MenuView extends StatefulWidget {
  const MenuView(this.game, {super.key});

  final Game game;

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.amber,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.play_arrow,
              size: 64,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome!\nSpace Jump Game",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () {
                game.startGame();
              },
              child: Text(
                "START",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.purple,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

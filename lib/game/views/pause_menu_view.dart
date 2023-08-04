import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

class PauseMenuView extends StatefulWidget {
  const PauseMenuView(this.game, {super.key});

  final Game game;

  @override
  State<PauseMenuView> createState() => _PauseMenuViewState();
}

class _PauseMenuViewState extends State<PauseMenuView> {
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
              "Pause Menu",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () => game.pauseGame(),
              child: Text(
                "Continue",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.purple,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => game.goMainMenu(),
              child: Text(
                "Home",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.orange,
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

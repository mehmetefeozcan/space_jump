import 'package:space_jump/game/core/enums/index.dart';
import 'package:space_jump/game/views/game_completed.dart';
import 'package:space_jump/game/views/index.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:space_jump/game/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:space_jump/game/views/store_view.dart';

void main() async {
  /// Hive init process
  await Hive.initFlutter();
  await Hive.openBox(HiveEnums.gameBox.value);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

final Game game = MyGame();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: GameWidget(
          game: game,
          overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
            'gameOverlay': (context, game) => GameView(game),
            'storeOverlay': (context, game) => StoreView(game),
            'mainMenuOverlay': (context, game) => MenuView(game),
            'pauseOverlay': (context, game) => PauseMenuView(game),
            'gameOverOverlay': (context, game) => GameOverView(game),
            'completeOverlay': (context, game) => GameCompletedView(game),
          },
        ),
      ),
    );
  }
}

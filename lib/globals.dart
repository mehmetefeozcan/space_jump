import 'package:space_jump/game/models/game_model.dart';
import 'package:flutter/material.dart';

ValueNotifier<GameLevelModel> gameLevelModel = ValueNotifier(GameLevelModel());

ValueNotifier<String> characterColor = ValueNotifier('grey');

ValueNotifier<int> gold = ValueNotifier(0);

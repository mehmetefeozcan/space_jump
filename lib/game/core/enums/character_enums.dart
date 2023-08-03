import 'package:flutter/material.dart';

enum CharacterEnums {
  greyLeft('grey_left'),
  greyRight('grey_right');

  final String value;
  const CharacterEnums(this.value);

  String get toPng => 'assets/images/character/pl_$value.png';
  Image get toImage => Image.asset(toPng);
}

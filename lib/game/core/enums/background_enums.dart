import 'package:flutter/material.dart';

enum BackgroundEnums {
  bg1('1'),
  bg2('2'),
  bg3('3'),
  bg4('4'),
  bg5('5'),
  bg6('6');

  final String value;
  const BackgroundEnums(this.value);

  String get toPng => 'assets/images/background/bg_$value.png';
  Image get toImage => Image.asset(toPng);
}

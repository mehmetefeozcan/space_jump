import 'package:flutter/material.dart';

enum ImageEnums {
  trampolineUp('trampoline_up'),
  trampolineDown('trampoline_down');

  final String value;
  const ImageEnums(this.value);

  String get toPng => 'assets/image/$value.png';
  Image get toImage => Image.asset(toPng);
}

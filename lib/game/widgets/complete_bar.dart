import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomCompleteBar extends StatelessWidget {
  final ValueListenable<double> value;
  const CustomCompleteBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: value,
      builder: (context, value, child) => LinearProgressIndicator(
        value: value,
        minHeight: 8,
      ),
    );
  }
}

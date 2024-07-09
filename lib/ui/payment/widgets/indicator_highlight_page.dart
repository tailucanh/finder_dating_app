import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  bool isActive;

  Indicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      width: isActive ? 22 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),

    );
  }
}

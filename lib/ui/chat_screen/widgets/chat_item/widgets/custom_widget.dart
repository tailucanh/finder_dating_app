import 'package:flutter/material.dart';

class ButtonNotification extends StatelessWidget {
  const ButtonNotification(
      {super.key,
        required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:  const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            border: Border.all(width: 2, color: Colors.grey)),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

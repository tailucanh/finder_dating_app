import 'package:flutter/material.dart';
class ButtonSubmitPageView extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const ButtonSubmitPageView(
      {super.key,
        required this.text,
        required this.color,
        required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color.fromRGBO(234, 64, 128, 1), Color.fromRGBO(238, 128, 95, 1)],
        ),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            backgroundColor: color,
          ),
          child: Text(text, style: const TextStyle(fontSize: 20, color:  Colors.white ,fontWeight: FontWeight.w600),)),
    );
  }
}

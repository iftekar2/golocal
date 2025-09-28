import 'package:flutter/material.dart';

class Googlebutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imagePath;
  final Color textColor;

  const Googlebutton({
    super.key,
    required this.onPressed,
    this.text = "Google",
    this.imagePath = 'lib/images/google-logo.png',
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 300,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,

          backgroundColor: const Color.fromRGBO(248, 247, 243, 1),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Color.fromARGB(255, 215, 214, 214),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 40, width: 40),
            const SizedBox(width: 15),
            Text(text, style: TextStyle(color: textColor, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

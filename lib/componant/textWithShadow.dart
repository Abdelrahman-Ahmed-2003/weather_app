import 'package:flutter/material.dart';

class TextWithShadow extends StatelessWidget {
  String text;
  double font;
  TextWithShadow({super.key, required this.text, required this.font});

  @override
  Widget build(BuildContext context) {
    return Text(
      text, // Example date text
      style: TextStyle(
        fontSize: font,
        color: Colors.white,
        /*shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.8), // Shadow color for the text
            offset: Offset(15, 15), // Shadow position
            //blurRadius: 3, // Softness of the shadow
          ),
        ],*/
      ),
    );
  }
}

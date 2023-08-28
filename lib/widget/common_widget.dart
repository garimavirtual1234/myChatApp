import 'package:flutter/material.dart';

class messageBubble extends StatelessWidget {
  const messageBubble({super.key,
  required this.color,
    required this.chatContent,
    required this.textColor
  });
final Color color;
final String chatContent;
final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Text(
        chatContent,
        style: TextStyle(
          color: textColor
        ),
      ),
    );
  }
}

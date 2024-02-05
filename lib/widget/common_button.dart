import 'package:flutter/material.dart';


class CommonButton extends StatelessWidget {
  final String content;
  final VoidCallback onPressed;
  const CommonButton({super.key,
required this.content,
required this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: onPressed,
      child: Container(
        height: 40,
      color: Colors.yellow,
      child: Center(
      child: Text(content,
style: const TextStyle(color: Colors.black,
fontSize: 18,
  fontWeight: FontWeight.bold
),
),
      ),
      ),
    );
  }
}

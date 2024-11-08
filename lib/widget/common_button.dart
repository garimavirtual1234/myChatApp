import 'package:chat_bot_demo/module/utils/app_theme.dart';
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
      color: CustomTheme.lightThemeColor,
      child: Center(
      child: Text(content,
style: Theme.of(context).textTheme.bodyMedium
),
      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.titleText,
    required this.textColor,
    this.textSize,
    required this.function,
  });

  final String titleText;
  final Color textColor;
  final double? textSize;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: function,
        child: Text(
          titleText,
          style: TextStyle(color: textColor),
        ));
  }
}

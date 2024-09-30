import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    required this.imagePath,
    required this.buttonText,
    this.function,
  });

  final String imagePath;
  final String buttonText;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: Image.asset(imagePath),
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppPalette.whiteColor),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
                horizontal: AppSizes.btnHorPadding / 1.8,
                vertical: AppSizes.btnVerPadding / 1.8)),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.btnVerPadding / 1.8)))),
        onPressed: function,
        label: Text(
          buttonText,
          style: const TextStyle(color: AppPalette.greyColor),
        ));
  }
}

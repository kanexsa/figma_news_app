import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.function,
  });

  final String text;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppPalette.greenColor),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: AppSizes.btnHorPadding,
            vertical: AppSizes.btnVerPadding,
          ),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.btnVerPadding),
            side: const BorderSide(color: AppPalette.greenColor),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.onboardDescTextSize,
          ),
        ),
      ),
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          color: AppPalette.whiteColor,
        ),
      ),
    );
  }
}

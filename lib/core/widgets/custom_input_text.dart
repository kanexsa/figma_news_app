import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  const CustomInputText({
    super.key,
    required this.labelText,
    this.suffixIcon,
    required this.controller,
  });

  final String labelText;
  final Icon? suffixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.textInputHorPadding,
          vertical: AppSizes.textInputVerPadding),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppPalette.whiteColor,
            label: Text(labelText,
                style: const TextStyle(
                    color: AppPalette.greyColor,
                    fontSize: AppSizes.textInputTextSizes)),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppSizes.textInputRadius)))),
      ),
    );
  }
}

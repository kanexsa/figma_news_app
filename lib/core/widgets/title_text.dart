import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.titleText,
  });

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.onboardTitleTextSize,
          color: AppPalette.blackColor),
    );
  }
}

class DescText extends StatelessWidget {
  const DescText({
    super.key,
    required this.descText,
  });

  final String descText;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      descText,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: AppSizes.onboardDescTextSize,
          color: AppPalette.greyColor),
    );
  }
}

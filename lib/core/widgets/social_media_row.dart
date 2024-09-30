import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:figma_news_app/core/utils/image_paths.dart';
import 'package:figma_news_app/core/widgets/custom_button_with_icon.dart';
import 'package:flutter/material.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButtonWithIcon(
          imagePath: ImagePaths.ic_google,
          buttonText: AppTexts.googleText,
        ),
        CustomButtonWithIcon(
          imagePath: ImagePaths.ic_facebook,
          buttonText: AppTexts.facebookText,
        ),
      ],
    );
  }
}

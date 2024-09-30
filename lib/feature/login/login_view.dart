import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/routes/app_routes.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:figma_news_app/core/utils/image_paths.dart';
import 'package:figma_news_app/core/widgets/background_container.dart';
import 'package:figma_news_app/core/widgets/custom_button.dart';
import 'package:figma_news_app/core/widgets/custom_button_with_icon.dart';
import 'package:figma_news_app/core/widgets/custom_input_text.dart';
import 'package:figma_news_app/core/widgets/custom_text_button.dart';
import 'package:figma_news_app/core/widgets/social_media_row.dart';
import 'package:figma_news_app/core/widgets/title_text.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppTexts.loginTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppPalette.splashTitleBlackColor,
                fontSize: AppSizes.splashTitleTextSize),
          ),
          const SizedBox(height: AppSizes.paddingLow),
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppSizes.onboardDescPadding),
            child: DescText(descText: AppTexts.logSignDesc),
          ),
          const SizedBox(
            height: AppSizes.paddingMedium,
          ),
          const SocialMediaRow(),
          const SizedBox(
            height: AppSizes.paddingMedium,
          ),
          //const CustomInputText(labelText: AppTexts.emailHintText),
          // const CustomInputText(
          //   labelText: AppTexts.passwordHintText,
          //   suffixIcon: Icon(Icons.password),
          // ),
          const SizedBox(
            height: AppSizes.paddingMedium,
          ),
          const CustomButton(text: AppTexts.login),
          CustomTextButton(
            titleText: AppTexts.dontHaveAnAccount,
            textColor: AppPalette.greenColor,
            function: () {
              Navigator.pushReplacementNamed(context, AppRoutes.signup);
            },
          )
        ],
      )),
    );
  }
}

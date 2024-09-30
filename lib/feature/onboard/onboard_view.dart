import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/routes/app_routes.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:figma_news_app/core/utils/onboard_enum.dart';
import 'package:figma_news_app/core/utils/page_transition_duration.dart';
import 'package:figma_news_app/core/widgets/background_container.dart';
import 'package:figma_news_app/core/widgets/custom_button.dart';
import 'package:figma_news_app/core/widgets/custom_text_button.dart';
import 'package:figma_news_app/core/widgets/title_text.dart';
import 'package:flutter/material.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
            child: PageView(
                controller: _pageController,
                children: OnboardEnum.values.map((page) {
                  return OnboardBody(
                      onboardEnum: page, pageController: _pageController);
                }).toList())));
  }
}

class OnboardBody extends StatelessWidget {
  const OnboardBody({
    super.key,
    required this.pageController,
    required this.onboardEnum,
  });

  final PageController pageController;
  final OnboardEnum onboardEnum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(onboardEnum.imagePath),
        const SizedBox(
          height: AppSizes.paddingBig,
        ),
        Center(child: TitleText(titleText: onboardEnum.titleText)),
        const SizedBox(height: AppSizes.paddingLow),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppSizes.onboardDescPadding),
          child: DescText(descText: AppTexts.onboardDesc),
        ),
        const SizedBox(
          height: AppSizes.paddingMedium,
        ),
        Center(
          child: CustomButton(
            text: AppTexts.buttonGetStarted,
            function: () {
              if (onboardEnum == OnboardEnum.pageThree) {
                Navigator.pushReplacementNamed(context, AppRoutes.signup);
              } else {
                pageController.nextPage(
                    duration: PageTransitionDuration.short.duration,
                    curve: Curves.easeInOut);
              }
            },
          ),
        ),
        const SizedBox(height: AppSizes.paddingLow),
        Center(
          child: CustomTextButton(
              titleText: AppTexts.textSkip,
              textColor: AppPalette.greyColor,
              function: () {
                Navigator.pushReplacementNamed(context, AppRoutes.signup);
              }),
        )
      ],
    );
  }
}

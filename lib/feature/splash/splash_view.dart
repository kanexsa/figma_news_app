import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/routes/app_routes.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:figma_news_app/core/utils/image_paths.dart';
import 'package:figma_news_app/core/utils/page_transition_duration.dart';
import 'package:figma_news_app/core/widgets/background_container.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  _navigateToOnboarding() async {
    await Future.delayed(PageTransitionDuration.long.duration, () {});
    Navigator.pushReplacementNamed(context, AppRoutes.onboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(ImagePaths.logo),
            ),
            const SizedBox(
              height: AppSizes.paddingLow,
            ),
            const Center(
              child: Text(
                AppTexts.splashTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppPalette.splashTitleBlackColor,
                    fontSize: AppSizes.splashTitleTextSize),
              ),
            )
          ],
        ),
      ),
    );
  }
}

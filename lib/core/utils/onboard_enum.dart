import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:figma_news_app/core/utils/image_paths.dart';

enum OnboardEnum {
  pageOne,
  pageTwo,
  pageThree,
}

extension OnboardPageExtension on OnboardEnum {
  int get index {
    switch (this) {
      case OnboardEnum.pageOne:
        return 0;
      case OnboardEnum.pageTwo:
        return 1;
      case OnboardEnum.pageThree:
        return 2;
    }
  }

  String get imagePath {
    switch (this) {
      case OnboardEnum.pageOne:
        return ImagePaths.onboard_logo_one;
      case OnboardEnum.pageTwo:
        return ImagePaths.onboard_logo_two;
      case OnboardEnum.pageThree:
        return ImagePaths.onboard_logo_three;
    }
  }

  String get titleText {
    switch (this) {
      case OnboardEnum.pageOne:
        return AppTexts.onboardTitleOne;
      case OnboardEnum.pageTwo:
        return AppTexts.onboardTitleTwo;
      case OnboardEnum.pageThree:
        return AppTexts.onboardTitleThree;
    }
  }
}

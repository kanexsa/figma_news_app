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
import 'package:figma_news_app/product/services/sign_up/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: BackgroundContainer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppTexts.signUpTitle,
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
          CustomInputText(
            labelText: AppTexts.nameHintText,
            controller: _nameController,
          ),
          CustomInputText(
            labelText: AppTexts.emailHintText,
            controller: _emailController,
          ),
          CustomInputText(
            controller: _passwordController,
            labelText: AppTexts.passwordHintText,
            suffixIcon: const Icon(Icons.password),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.paddingLow),
            child: Row(
              children: [
                Checkbox(
                  side: BorderSide.none,
                  fillColor: WidgetStateProperty.all(AppPalette.greyColor),
                  shape: const CircleBorder(),
                  value: signUpProvider.isAgreed,
                  onChanged: (value) {
                    signUpProvider.toggleAgreement(value!);
                  },
                ),
                const Text(
                  AppTexts.privacyPolicy,
                  style: TextStyle(
                      fontSize: AppSizes.privacyPolicyTextSizes,
                      color: AppPalette.greyColor),
                )
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.paddingMedium,
          ),
          signUpProvider.isLoading
              ? Lottie.asset(
                  ImagePaths.loading_animation,
                  height: 100,
                  width: 100,
                )
              : signUpProvider.isSuccess
                  ? Lottie.asset(
                      ImagePaths.success_animation,
                      height: 100,
                      width: 100,
                    )
                  : CustomButton(
                      text: AppTexts.signUp,
                      function: () async {
                        signUpProvider.clearErrors();
                        final errorMessage = signUpProvider.validateFields(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );

                        if (errorMessage != null) {
                          signUpProvider.showErrorSnackbar(
                              context, errorMessage);
                          return;
                        }

                        try {
                          Lottie.asset(ImagePaths.success_animation);
                        } catch (e) {
                          print("Animasyon yüklenirken hata oluştu: $e");
                        }

                        try {
                          await signUpProvider.signUpWithEmailAndPassword(
                            _emailController.text,
                            _passwordController.text,
                          );
                          // Navigate to another screen or show a success message
                        } catch (e) {
                          signUpProvider.showErrorSnackbar(
                              context, e.toString());
                        }
                      },
                    ),
          CustomTextButton(
            titleText: AppTexts.haveAnAccountLogin,
            textColor: AppPalette.greenColor,
            function: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          )
        ],
      )),
    );
  }
}

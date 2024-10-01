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
import 'package:figma_news_app/product/services/login/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bottomSheetEmailController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
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
          CustomInputText(
            labelText: AppTexts.emailHintText,
            controller: _emailController,
            errorText: loginProvider.emailError,
          ),
          CustomInputText(
            labelText: AppTexts.passwordHintText,
            controller: _passwordController,
            errorText: loginProvider.passwordError,
            obscureText: loginProvider.isPasswordObscured,
            suffixIcon: InkWell(
              onTap: () {
                loginProvider.togglePasswordVisibility();
              },
              child: Icon(
                loginProvider.isPasswordObscured
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.paddingMedium,
          ),
          loginProvider.isLoading
              ? Lottie.asset(
                  ImagePaths.loading_animation,
                  height: 100,
                  width: 100,
                )
              : CustomButton(
                  text: AppTexts.login,
                  function: () async {
                    loginProvider.clearErrors();
                    try {
                      await loginProvider.signInWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                        context,
                      );
                    } catch (e) {
                      loginProvider.showErrorSnackbar(context, e.toString());
                    }
                  },
                ),
          CustomTextButton(
            titleText: AppTexts.forgotPassword,
            textColor: AppPalette.greenColor,
            function: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleText(titleText: AppTexts.forgotPassword),
                        const SizedBox(height: 8.0),
                        const DescText(
                            descText: AppTexts.bottomSheetForgotPasswordDesc),
                        const SizedBox(height: 16.0),
                        CustomInputText(
                          labelText: AppTexts.emailHintText,
                          controller: _bottomSheetEmailController,
                        ),
                        const SizedBox(height: 12.0),
                        Center(
                            child: CustomButton(
                          text: AppTexts.continueText,
                          function: () async {
                            final email = _bottomSheetEmailController.text;

                            bool emailExists =
                                await loginProvider.checkEmailExists(email);
                            if (emailExists) {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 24),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ))
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(
            height: AppSizes.paddingMedium,
          ),
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

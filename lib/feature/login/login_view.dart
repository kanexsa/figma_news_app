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
  final TextEditingController _bottomSheetPasswordController =
      TextEditingController();
  final TextEditingController _bottomSheetRePasswordController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<TextEditingController> _codeControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _bottomSheetEmailController.dispose();
    _passwordController.dispose();
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    _bottomSheetPasswordController.dispose();
    _bottomSheetRePasswordController.dispose();
  }

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
                      await loginProvider.verifyEmailAndNavigate(context);
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
                              try {
                                await loginProvider.sendVerificationCode(email);
                                Navigator.pop(context);
                                _bottomSheetEmailController.clear();
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const TitleText(
                                              titleText: AppTexts.enterDigit),
                                          const SizedBox(height: 8.0),
                                          const DescText(
                                              descText:
                                                  AppTexts.enterDigitDesc),
                                          const SizedBox(height: 16.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              _buildCodeInputFields(context),
                                            ],
                                          ),
                                          const SizedBox(height: 12.0),
                                          Center(
                                            child: CustomButton(
                                              text: AppTexts.continueText,
                                              function: () async {
                                                final enteredCode =
                                                    _codeControllers
                                                        .map((controller) =>
                                                            controller.text)
                                                        .join();

                                                bool isVerified =
                                                    await loginProvider
                                                        .verifyCode(
                                                            enteredCode);
                                                if (isVerified) {
                                                  Navigator.of(context).pop();

                                                  for (var controller
                                                      in _codeControllers) {
                                                    controller.clear();
                                                  }
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16,
                                                                vertical: 24),
                                                        child: Consumer<
                                                            LoginProvider>(
                                                          builder: (context,
                                                              value, child) {
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const TitleText(
                                                                    titleText:
                                                                        AppTexts
                                                                            .resetPassword),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                const DescText(
                                                                    descText:
                                                                        AppTexts
                                                                            .resetDescPassword),
                                                                const SizedBox(
                                                                  height: 16,
                                                                ),
                                                                CustomInputText(
                                                                  labelText:
                                                                      AppTexts
                                                                          .passwordHintText,
                                                                  controller:
                                                                      _bottomSheetPasswordController,
                                                                  obscureText:
                                                                      loginProvider
                                                                          .isBottomSheetPasswordObscured,
                                                                  suffixIcon:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      loginProvider
                                                                          .toggleBottomSheetPasswordVisibility();
                                                                    },
                                                                    child: Icon(
                                                                      loginProvider.isBottomSheetPasswordObscured
                                                                          ? Icons
                                                                              .visibility_off
                                                                          : Icons
                                                                              .visibility,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                CustomInputText(
                                                                  labelText:
                                                                      AppTexts
                                                                          .rePasswordHintText,
                                                                  controller:
                                                                      _bottomSheetRePasswordController,
                                                                  obscureText:
                                                                      loginProvider
                                                                          .isBottomSheetRePasswordObscured,
                                                                  suffixIcon:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      loginProvider
                                                                          .toggleBottomSheetRePasswordVisibility();
                                                                    },
                                                                    child: Icon(
                                                                      loginProvider.isBottomSheetRePasswordObscured
                                                                          ? Icons
                                                                              .visibility_off
                                                                          : Icons
                                                                              .visibility,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 12,
                                                                ),
                                                                Center(
                                                                  child:
                                                                      CustomButton(
                                                                    text: AppTexts
                                                                        .updatePassword,
                                                                    function:
                                                                        () async {
                                                                      final newPassword =
                                                                          _bottomSheetPasswordController
                                                                              .text;
                                                                      final repassword =
                                                                          _bottomSheetRePasswordController
                                                                              .text;

                                                                      await loginProvider.updatePassword(
                                                                          newPassword,
                                                                          repassword,
                                                                          context);
                                                                    },
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  loginProvider
                                                      .showErrorSnackbar(
                                                          context,
                                                          AppTexts
                                                              .failOTPVerify);
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              } catch (e) {
                                loginProvider.showErrorSnackbar(
                                    context, e.toString());
                              }
                            } else {
                              loginProvider.showErrorSnackbar(
                                  context, AppTexts.notFoundEmail);
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

  Widget _buildCodeInputFields(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          4,
          (index) => Padding(
                padding: const EdgeInsets.all(AppSizes.paddingLow),
                child: _buildCodeInput(context, index),
              )),
    );
  }

  Widget _buildCodeInput(BuildContext context, int index) {
    return Container(
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AppPalette.greenColor),
        borderRadius: BorderRadius.circular(AppSizes.paddingLow),
      ),
      child: TextField(
        controller: _codeControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppPalette.greenColor,
        ),
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 3) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}

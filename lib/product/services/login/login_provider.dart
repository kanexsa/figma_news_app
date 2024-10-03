import 'package:email_otp/email_otp.dart';
import 'package:figma_news_app/core/routes/app_routes.dart';
import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:figma_news_app/core/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;
  bool _isPasswordObscured = true;
  bool _isBottomSheetPasswordObscured = true;
  bool _isBottomSheetRePasswordObscured = true;
  String? _emailError;
  String? _passwordError;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isPasswordObscured => _isPasswordObscured;
  bool get isBottomSheetPasswordObscured => _isBottomSheetPasswordObscured;
  bool get isBottomSheetRePasswordObscured => _isBottomSheetRePasswordObscured;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;

  LoginProvider() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      _emailError = null;
      _passwordError = null;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        await _auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case AppTexts.userNotFoundCode:
          _emailError = AppTexts.userNotFoundError;
          break;
        case AppTexts.wrongPasswordCode:
          _passwordError = AppTexts.wrongPasswordError;
          break;
        case AppTexts.invalidEmailCode:
          _emailError = AppTexts.invalidEmailError;
          break;
        case AppTexts.invalidCredentialCode:
          _emailError = AppTexts.invalidCredentialError;
          break;
        default:
          showErrorSnackbar(context, AppTexts.defaultError);
      }
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyEmailAndNavigate(BuildContext context) async {
    final user = _auth.currentUser;
    if (user != null && user.emailVerified) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      showErrorSnackbar(context, AppTexts.notVerifyEmailCheck);
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      final result = await _auth.fetchSignInMethodsForEmail(email);

      return result.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<void> sendVerificationCode(String email) async {
    EmailOTP.config(
      appName: 'Figma News App',
      appEmail: 'noreply@figmanewsapp.com',
      otpLength: 4,
      expiry: 50000, // milliseconds
    );

    await EmailOTP.sendOTP(email: email);
  }

  Future<void> updatePassword(
      String newPassword, String newRePassword, BuildContext context) async {
    if (newPassword != newRePassword) {
      showErrorSnackbar(context, AppTexts.notMatchPassword);
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      final user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        showSuccessSnackbar(context, AppTexts.updatePasswordSuccess);
      } else {
        showErrorSnackbar(context, AppTexts.updatePasswordError);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case AppTexts.weakPasswordCode:
          showErrorSnackbar(context, AppTexts.weakPasswordError);
          break;
        default:
          showErrorSnackbar(
              context, "${AppTexts.defaultUpdatePasswordError} ${e.message}");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> verifyCode(String code) async {
    return EmailOTP.verifyOTP(otp: code);
  }

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void toggleBottomSheetPasswordVisibility() {
    _isBottomSheetPasswordObscured = !_isBottomSheetPasswordObscured;
    notifyListeners();
  }

  void toggleBottomSheetRePasswordVisibility() {
    _isBottomSheetRePasswordObscured = !_isBottomSheetRePasswordObscured;
    notifyListeners();
  }

  void showErrorSnackbar(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomSnackbar(message: message);
      },
    );
  }

  void showSuccessSnackbar(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CustomSnackbar(message: message, color: Colors.green);
      },
    );
  }

  void clearErrors() {
    _emailError = null;
    _passwordError = null;
    notifyListeners();
  }
}

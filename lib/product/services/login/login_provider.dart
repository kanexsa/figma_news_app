import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;
  bool _isPasswordObscured = true;
  String? _emailError;
  String? _passwordError;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isPasswordObscured => _isPasswordObscured;
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
        showErrorSnackbar(context, AppTexts.notVerifyEmailCheck);
        throw AppTexts.notVerifyEmail;
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
    } catch (e) {
      showErrorSnackbar(context, AppTexts.defaultLoginError);
    } finally {
      _isLoading = false;
      notifyListeners();
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

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  void showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void clearErrors() {
    _emailError = null;
    _passwordError = null;
    notifyListeners();
  }
}

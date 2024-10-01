import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isAgreed = false;
  bool _isLoading = false;
  bool _isSuccess = false;
  bool _isPasswordObscured = true;

  User? get user => _user;
  bool get isAgreed => _isAgreed;
  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;
  bool get isPasswordObscured => _isPasswordObscured;

  SignUpProvider() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _isLoading = false;
      _isSuccess = true;
      notifyListeners();

      await _auth.currentUser?.sendEmailVerification();

      await Future.delayed(const Duration(seconds: 2));
      _isSuccess = false;
      notifyListeners();
    } catch (e) {
      throw AppTexts.defaultSignUpError;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleAgreement(bool value) {
    _isAgreed = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordObscured = !_isPasswordObscured;
    notifyListeners();
  }

  bool isEmailValid(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  bool areFieldsFilled(String name, String email, String password) {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        _isAgreed;
  }

  String? validateFields(String name, String email, String password) {
    clearErrors();
    if (name.isEmpty) {
      return AppTexts.nameError;
    }
    if (!isEmailValid(email)) {
      return AppTexts.validEmailError;
    }
    if (email.isEmpty) {
      return AppTexts.emailError;
    }
    if (password.isEmpty) {
      return AppTexts.passwordError;
    }
    if (!isAgreed) {
      return AppTexts.privacyPolicyError;
    }
    return null;
  }

  void showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void clearAllFields(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController) {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    _isAgreed = false;
    notifyListeners();
  }

  void clearErrors() {
    notifyListeners();
  }
}

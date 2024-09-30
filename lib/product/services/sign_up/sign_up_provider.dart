import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isAgreed = false;
  bool _isLoading = false;
  bool _isSuccess = false;

  String? _emailError;
  String? _passwordError;
  String? _nameError;
  String? _agreementError;

  User? get user => _user;
  bool get isAgreed => _isAgreed;
  bool get isLoading => _isLoading;
  bool get isSuccess => _isSuccess;

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

      _isSuccess = true;
      notifyListeners();

      // Başarı animasyonunu 2 saniye göster
      await Future.delayed(const Duration(seconds: 2));
      _isSuccess = false; // Durumu sıfırla
      notifyListeners();
    } catch (e) {
      throw "Kayıt işlemi başarısız. Lütfen tekrar deneyin.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleAgreement(bool value) {
    _isAgreed = value;
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
      return "Name cannot be empty.";
    }
    if (!isEmailValid(email)) {
      return "Invalid email format.";
    }
    if (email.isEmpty) {
      return "Email cannot be empty.";
    }
    if (password.isEmpty) {
      return "Password cannot be empty.";
    }
    if (!isAgreed) {
      return "You must agree to the privacy policy.";
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

  void clearErrors() {
    notifyListeners();
  }
}

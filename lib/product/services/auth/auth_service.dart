import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Anonim olarak oturum açma
  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print('Failed to sign in anonymously: $e');
      return null;
    }
  }

  //Çıkış yapma
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }

  //Oturum açma durumunu dinleme
  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}

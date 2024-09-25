import 'package:figma_news_app/feature/data/data_view.dart';
import 'package:figma_news_app/product/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: StreamBuilder<User?>(
        stream: _authService.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              return Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await _authService.signInAnonymously();
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to sign in anonymously'),
                          ),
                        );
                      }
                    },
                    child: const Text("Sign in anonymously")),
              );
            } else {
              //Oturum açıldığında view yönlendirme
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DataView(),
                    ));
              });
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Signed in as ${user.uid}'),
                    ElevatedButton(
                        onPressed: () async {
                          await _authService.signOut();
                        },
                        child: const Text('Sign Out'))
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

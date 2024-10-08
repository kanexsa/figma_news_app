import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _name;
  String? _phone;
  String? _description;
  String? _email;

  String get name => _name ?? '';
  String get phone => _phone ?? '';
  String get description => _description ?? '';
  String get email => _email ?? '';

  ProfileProvider() {
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      _email = user.email;
      DocumentSnapshot userData =
          await _firestore.collection('users').doc(user.uid).get();
      _name = userData.get('name') as String?;
      _phone = userData.get('phone') as String?;
      _description = userData.get('description') as String?;
      notifyListeners();
    }
  }

  Future<void> saveProfileData(
      String name, String phone, String description) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'phone': phone,
        'description': description,
      });
      _name = name;
      _phone = phone;
      _description = description;
      notifyListeners();
    }
  }
}

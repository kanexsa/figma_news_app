import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_news_app/core/routes/app_routes.dart';
import 'package:figma_news_app/product/models/doctor_model.dart';
import 'package:figma_news_app/product/services/favorites/doctor_favorite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorProvider with ChangeNotifier {
  List<DoctorModel> _doctors = [];
  List<String> _favoriteDoctors = [];
  List<DoctorModel> _popularDoctors = [];
  List<DoctorModel> _liveDoctors = [];
  late FavoriteDoctorsService _favoriteService;

  List<DoctorModel> get doctors => _doctors;
  List<DoctorModel> get popularDoctors => _popularDoctors;
  List<DoctorModel> get liveDoctors => _liveDoctors;
  List<String> get favoriteDoctors => _favoriteDoctors;

  DoctorProvider() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      _favoriteService = FavoriteDoctorsService(userId);
      await loadFavoriteDoctors();
    } else {
      _doctors = [];
      _popularDoctors = [];
      _liveDoctors = [];
      _favoriteDoctors = [];
    }
    notifyListeners();
  }

  Future<void> fetchDoctors() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    _doctors =
        snapshot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> fetchPopularDoctors() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('rating', isGreaterThanOrEqualTo: 4.5)
        .get();
    _popularDoctors =
        snapshot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();

    notifyListeners();
  }

  Future<void> fetchLiveDoctors() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('isLive', isEqualTo: true)
        .get();
    _liveDoctors =
        snapshot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> loadFavoriteDoctors() async {
    _favoriteDoctors = await _favoriteService.getFavoriteDoctors();
    notifyListeners();
  }

  Future<void> toggleFavoriteDoctor(DoctorModel doctor) async {
    if (_favoriteDoctors.contains(doctor.id)) {
      await _favoriteService.removeFavoriteDoctor(doctor.id);
      _favoriteDoctors.remove(doctor.id);
    } else {
      await _favoriteService.addFavoriteDoctor(doctor.id);
      _favoriteDoctors.add(doctor.id);
    }
    notifyListeners();
  }

  bool isFavorite(DoctorModel doctor) {
    return _favoriteDoctors.contains(doctor.id);
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    _doctors = [];
    _popularDoctors = [];
    _liveDoctors = [];
    _favoriteDoctors = [];

    notifyListeners();

    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }
}

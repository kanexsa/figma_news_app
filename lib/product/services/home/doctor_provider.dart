import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_news_app/product/models/doctor_model.dart';
import 'package:figma_news_app/product/services/shared/doctor_favorite.dart';
import 'package:flutter/material.dart';

class DoctorProvider with ChangeNotifier {
  List<DoctorModel> _doctors = [];
  List<String> _favoriteDoctors = [];

  List<DoctorModel> get doctors => _doctors;
  List<String> get favoriteDoctors => _favoriteDoctors;

  Future<void> fetchDoctors() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('doctors').get();
    _doctors =
        snapshot.docs.map((doc) => DoctorModel.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> loadFavoriteDoctors() async {
    final service = FavoriteDoctorsService();
    _favoriteDoctors = await service.getFavoriteDoctors();
    notifyListeners();
  }

  Future<void> toggleFavoriteDoctor(DoctorModel doctor) async {
    final service = FavoriteDoctorsService();
    if (_favoriteDoctors.contains(doctor.id)) {
      await service.removeFavoriteDoctor(doctor.id);
      _favoriteDoctors.remove(doctor.id);
    } else {
      await service.addFavoriteDoctor(doctor.id);
      _favoriteDoctors.add(doctor.id);
    }
    notifyListeners();
  }

  bool isFavorite(DoctorModel doctor) {
    return _favoriteDoctors.contains(doctor.id);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma_news_app/product/models/doctor_model.dart';
import 'package:flutter/material.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> _doctors = [];

  List<DoctorModel> get doctors => _doctors;

  Future<void> fetchDoctors() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('doctors').get();
      _doctors =
          snapshot.docs.map((doc) => DoctorModel.fromJson(doc.data())).toList();
      notifyListeners();
    } catch (error) {
      print("Error fetching doctors: $error");
    }
  }
}

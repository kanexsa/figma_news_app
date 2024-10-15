import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final double hourlyRate;
  final bool isLive;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.hourlyRate,
    required this.isLive,
  });

  factory DoctorModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DoctorModel(
      id: doc.id,
      name: data['name'] ?? '',
      specialty: data['specialty'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      rating: data['rating']?.toDouble() ?? 0.0,
      hourlyRate: data['hourlyRate']?.toDouble() ?? 0.0,
      isLive: data['isLive'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'specialty': specialty,
      'imageUrl': imageUrl,
      'rating': rating,
      'hourlyRate': hourlyRate,
      'isLive': isLive,
    };
  }
}

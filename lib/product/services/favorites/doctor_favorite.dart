import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteDoctorsService {
  final String userId;

  FavoriteDoctorsService(this.userId);

  Future<List<String>> getFavoriteDoctors() async {
    final doc = await FirebaseFirestore.instance
        .collection('user_favorites')
        .doc(userId)
        .get();

    if (doc.exists) {
      return List<String>.from(doc.data()?['favorites'] ?? []);
    } else {
      return [];
    }
  }

  Future<void> addFavoriteDoctor(String doctorId) async {
    final favorites = await getFavoriteDoctors();
    if (!favorites.contains(doctorId)) {
      favorites.add(doctorId);
      await FirebaseFirestore.instance
          .collection('user_favorites')
          .doc(userId)
          .set({'favorites': favorites});
    }
  }

  Future<void> removeFavoriteDoctor(String doctorId) async {
    final favorites = await getFavoriteDoctors();
    favorites.remove(doctorId);
    await FirebaseFirestore.instance
        .collection('user_favorites')
        .doc(userId)
        .set({'favorites': favorites});
  }
}

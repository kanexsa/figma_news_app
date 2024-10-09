import 'package:shared_preferences/shared_preferences.dart';

class FavoriteDoctorsService {
  static const String _favoriteDoctorsKey = 'favorite_doctors';

  Future<List<String>> getFavoriteDoctors() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteDoctorsKey) ?? [];
  }

  Future<void> addFavoriteDoctor(String doctorId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteDoctors();
    if (!favorites.contains(doctorId)) {
      favorites.add(doctorId);
      await prefs.setStringList(_favoriteDoctorsKey, favorites);
    }
  }

  Future<void> removeFavoriteDoctor(String doctorId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavoriteDoctors();
    favorites.remove(doctorId);
    await prefs.setStringList(_favoriteDoctorsKey, favorites);
  }
}

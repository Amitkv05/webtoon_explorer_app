import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> addFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favorite = sharedPreferences.getStringList('favorite') ?? [];
    favorite.add(id);
    return await sharedPreferences.setStringList('favorite', favorite);
  }

  static Future<bool> removeFavorite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> favorite = sharedPreferences.getStringList('favorite') ?? [];
    favorite.remove(id);
    return await sharedPreferences.setStringList('favorite', favorite);
  }

  static Future<List<String>> fetchFavorite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList('favorite') ?? [];
  }
}

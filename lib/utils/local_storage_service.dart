import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String likedPostIdsKey = 'liked_post_ids';

  static Future<List<String>?> retrieveLikedPostIds() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(likedPostIdsKey);
    } catch (e) {
      // Handle any errors that may occur during retrieval
      return null;
    }
  }

  static Future<void> storeLikedPostIds(List<String> likedPostIds) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(likedPostIdsKey, likedPostIds);
    } catch (e) {
      // Handle any errors that may occur during storage
    }
  }
}

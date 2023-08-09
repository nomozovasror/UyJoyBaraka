import 'package:uy_joy_baraka/utils/local_storage_service.dart';

class LikeController {
  List<String> _likedPostIds = [];

  List<String> get likedPostIds => _likedPostIds;

  Future<void> initializeLikedPostIds() async {
    _likedPostIds = await LocalStorageService.retrieveLikedPostIds() ?? [];
  }

  Future<void> like(String postID) async {
    await LocalStorageService.storeLikedPostIds(_likedPostIds);
  }

  Future<void> unlike(String postID) async {
    await LocalStorageService.storeLikedPostIds(_likedPostIds);
  }
}

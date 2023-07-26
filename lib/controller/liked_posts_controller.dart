import 'package:uy_joy_baraka/utils/local_storage_service.dart';

class LikeController {
  List<String> _likedPostIds = [];

  List<String> get likedPostIds => _likedPostIds;

  Future<void> initializeLikedPostIds() async {
    _likedPostIds = await LocalStorageService.retrieveLikedPostIds() ?? [];
  }

  Future<void> like(String postID) async {
    // Perform the like operation here and add the post ID to _likedPostIds list
    // ...

    // Store the updated likedPostIds list in local storage
    await LocalStorageService.storeLikedPostIds(_likedPostIds);
  }

  Future<void> unlike(String postID) async {
    // Perform the unlike operation here and remove the post ID from _likedPostIds list
    // ...

    // Store the updated likedPostIds list in local storage
    await LocalStorageService.storeLikedPostIds(_likedPostIds);
  }
}

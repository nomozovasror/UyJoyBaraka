import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/models/liked_posts.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:uy_joy_baraka/utils/local_storage_service.dart';

class LikeController extends GetxController {

  final RxList<LikeModel> _likedPosts = RxList<LikeModel>([]);
  List<LikeModel> get likedPosts => _likedPosts.toList();
  List<String> _likedPostIds = [];

  List<String> get likedPostIds => _likedPostIds;

  void printLikedPostIds() {
    print(_likedPostIds);
    print(likedPostIds);
  }

  @override
  void onInit() {
    initializeLikedPostIds();
    super.onInit();
  }

  void updateLikedPosts(List<LikeModel> newLikedPosts) {
    _likedPosts.value = newLikedPosts;
  }

  Future<void> initializeLikedPostIds() async {
    _likedPostIds = await LocalStorageService.retrieveLikedPostIds() ?? [];
  }

  Future<void> like(String announcementId) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    try {
      var url = Uri.parse(
          "${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.likeCounter}$announcementId/like");

      final SharedPreferences prefs = await _prefs;
      var headers = {
        'authorization': prefs.getString('token') ?? '',
      };

      http.Response jsonResponse = await http.patch(url, headers: headers);
      print(jsonResponse.statusCode.toString());
      print(jsonResponse.body.toString());

      // Add the liked post ID to the _likedPostIds list
      _likedPostIds.add(announcementId);

      // Store the updated likedPostIds list in local storage
      await LocalStorageService.storeLikedPostIds(_likedPostIds);
    } catch (e) {
      print(e.toString());
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Error'),
            children: [
              SimpleDialogOption(
                child: Text(e.toString()),
              )
            ],
          );
        },
      );
    }
  }

  Future<void> unlike(String announcementId) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    try {
      var url = Uri.parse(
          "${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.likeCounter}$announcementId/unlike");

      final SharedPreferences prefs = await _prefs;
      var headers = {
        'authorization': prefs.getString('token') ?? '',
      };

      http.Response jsonResponse = await http.patch(url, headers: headers);
      print(jsonResponse.statusCode.toString());
      print(jsonResponse.body.toString());

      // Remove the unliked post ID from the _likedPostIds list
      _likedPostIds.remove(announcementId);

      // Store the updated likedPostIds list in local storage
      await LocalStorageService.storeLikedPostIds(_likedPostIds);
    } catch (e) {
      print(e.toString());
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Error'),
            children: [
              SimpleDialogOption(
                child: Text(e.toString()),
              )
            ],
          );
        },
      );
    }
  }

  var loadLike = false.obs;
  List<LikeModel> allLikedPost = [];

  getAllLikedPosts() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    try {
      loadLike.value = true;
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.getLikedPosts);

      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token') ?? '',
      };

      http.Response response = await http.get(url, headers: headers);

      print("${response.statusCode} like ok >>>>>>>>>");

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        print(responseJson['posts'][0]);
        allLikedPost = (responseJson['posts'] as List)
            .map((e) => LikeModel.fromJson(e))
            .toList();
        loadLike.value = false;
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } catch (e) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Xato'),
            children: [
              SimpleDialogOption(
                child: Text(e.toString()),
              )
            ],
          );
        },
      );
    }
  }

  Future<void> fetchAndStoreLikedPosts() async {
    try {
      // Fetch liked posts from the backend API using getAllLikedPosts()
      List<LikeModel> likedPosts = await getAllLikedPosts();

      // Store the liked posts locally using shared preferences
      List<String> likedPostIds =
      likedPosts.map((post) => post.announcementId!).toList();
      await LocalStorageService.storeLikedPostIds(likedPostIds);
    } catch (e) {
      // Handle any errors that may occur during the fetch and store process
    }
  }

  bool isPostLiked(String postId) {
    // Check if the provided postId exists in the liked post IDs list
    return likedPostIds.contains(postId);
  }


  void removeLikedPost(String postId) {
    allLikedPost.removeWhere((post) => post.announcementId == postId);
  }

  Future<void> deleteAllLikedData() async {
    await LocalStorageService.storeLikedPostIds([]);
    _likedPostIds.clear();
    _likedPosts.clear();

  }

  Future<void> restoreLikedDataFromAPI() async {
    try {
      await getAllLikedPosts();

      List<String> likedPostIds = allLikedPost.map((post) => post.announcementId!).toList();

      await LocalStorageService.storeLikedPostIds(likedPostIds);

      _likedPostIds = likedPostIds;
    } catch (e) {
      // Handle any errors that may occur during data restoration from the API
      // You can show an error message or take appropriate actions here
    }
  }



}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/models/liked_posts.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LikeController extends GetxController {
  Future<void> like(announcementId) async {
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
          });
    }
  }

  Future<void> unlike(announcementId) async {
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
          });
    }
  }

  var loadLike = false.obs;
  List<LikeModel> allLikedPost = [];

  @override
  void onInit() {
    getAllLikedPosts();
    super.onInit();
  }

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

      print("${response.statusCode} like ok >>>>>>>>>",);

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
          });
    }
  }
}

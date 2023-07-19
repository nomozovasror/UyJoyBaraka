import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/models/home_item.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetAllItemController extends GetxController {

  var loadItem = false.obs;
  List<Posts> allItem = [];
  User? user;

  @override
  void onInit() {
    getAllItem();
    super.onInit();
  }

  getAllItem() async {
    try {
      loadItem.value = true;
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.home);

      http.Response response =
      await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        print(responseJson['posts'][0]['slug'].toString());
        allItem = (responseJson['posts'] as List)
            .map((e) => Posts.fromJson(e))
            .toList();
        loadItem.value = false;
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

  Future<void> getItemBySlug(String slug) async {

    try {
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.slugCall + slug);
      print(url);

      http.Response response =
      await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        user = User.fromJson(responseJson['user']);
        print(user.toString());
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } catch (e) {
      print(e.toString());
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



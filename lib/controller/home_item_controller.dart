import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/models/home_item.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetAllItemController extends GetxController {

  var loadItem = false.obs;
  List<Posts> allItem = [];
  var page = 1.obs;

  bool hasMoreData = true;
  bool isLoading = false;
  int limit = 10;

  @override
  void onInit() {
    getAllItem();
    super.onInit();
  }

  void loadNextPage() {
    if (!hasMoreData || isLoading) return;
    page.value++;
    getAllItem();
  }


  getAllItem() async {
    try {
      if (!hasMoreData || isLoading) return; // Don't fetch if there is no more data or an ongoing API call
      isLoading = true;

      var url = Uri.parse('${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.home}?c_page=${page.value}&p_page=$limit');

      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        if (responseJson.containsKey('posts')) {
          if (page.value == 1) {
            allItem = (responseJson['posts'] as List).map((e) => Posts.fromJson(e)).toList();
          } else {
            allItem.addAll((responseJson['posts'] as List).map((e) => Posts.fromJson(e)).toList());
          }
          // Check if there is more data to load
          hasMoreData = (responseJson['posts'] as List).length == 10;
          // Increment the page number for the next request
          page.value++;
        } else {
          // No more data for the next page
          hasMoreData = false;
        }
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
    }finally {
      isLoading = false; // Reset the isLoading flag regardless of success or failure
      loadItem.value = false; // Set loadItem to false after the API call is complete
    }
  }
}



import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../models/search_model.dart';

class GetSearchItemController extends GetxController {
  var loadItem = false.obs;
  var startSearch = false.obs;
  RxList<SearchPosts> allSearchedPost = <SearchPosts>[].obs;

  var page = 1.obs;

  var isSearchLoading = false.obs;
  var hasMoreData = true.obs;
  int limit = 10;

  void loadNextPage() {
    page.value++;
    getSearchItem();
  }

  var city = "".obs;
  var type = "".obs;
  var priceType = "".obs;

  TextEditingController searchController = TextEditingController();

  getSearchItem([String? valyuta, String? viloyat, String? ijaraValue]) async {
    if (!hasMoreData.value || isSearchLoading.value) return;
    if (page.value == 1) {
      city.value = viloyat ?? "";
      type.value = ijaraValue ?? "";
      priceType.value = valyuta ?? "";
    }
    try {
      startSearch.value = true;
      isSearchLoading.value = true;

      var url = Uri.parse(
          '${ApiEndPoints.BASE_URL}${'${ApiEndPoints.authEndPoints.search}?'}${searchController.text.isNotEmpty ? 'search=${searchController.text}' : ""}${city.isNotEmpty ? '&city=$city' : ""}${type.isNotEmpty ? '&type=$type' : ""}${priceType.isNotEmpty ? '&price_type=$priceType' : ""}&c_page=${page.value}&p_page=$limit');

      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        if (responseJson.containsKey('posts')) {
          if (page.value == 1) {
            allSearchedPost.value = (responseJson['posts'] as List)
                .map((e) => SearchPosts.fromJson(e))
                .toList();
          } else {
            allSearchedPost.addAll((responseJson['posts'] as List)
                .map((e) => SearchPosts.fromJson(e))
                .toList());
          }
          hasMoreData.value = (responseJson['posts'] as List).length == 10;
        } else {
          hasMoreData.value = false;
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Column(
              children: [
                Text('Sizda internet mavjud emas'),
                Text(
                  "Yoki server bilan bog'lanishda xatolik yuz berdi",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            children: [
              SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset("assets/lottie/internet_error.json",
                            height: 200,
                            options: LottieOptions(
                              enableMergePaths: true,
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          getSearchItem();
                        },
                        child: const Text('Qayta urinib ko\'rish'),
                      )
                    ],
                  ))
            ],
          );
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
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
    } finally {
      isSearchLoading.value =
          false; // Reset the isLoading flag regardless of success or failure
      loadItem.value =
          false; // Set loadItem to false after the API call is complete
    }
  }
}

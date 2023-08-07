import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:uy_joy_baraka/models/home_item.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../models/search_model.dart';

class GetSearchItemController extends GetxController {

  var loadItem = true.obs;
  RxList<SearchPosts> allSearchedPost = <SearchPosts>[].obs;

  var isLoading = false.obs;

  TextEditingController searchController = TextEditingController();

  getSearchItem(String valyuta, String viloyat, String ijaraValue) async {
    try {
      isLoading.value = true;

      var url = Uri.parse('${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.search}?search=${searchController.text}');
      print(url);

      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        print(responseJson.toString());
        print(responseJson['posts'].toString());
        allSearchedPost.value = (responseJson['posts'] as List)
            .map((p) => SearchPosts.fromJson(p))
            .toList();
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } on SocketException catch(e){
      print(e.toString());
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Column(children: [
              Text('Sizda internet mavjud emas'),
              Text("Yoki server bilan bog'lanishda xatolik yuz berdi", style: TextStyle(fontSize: 12, color: Colors.grey),)
            ],),
            children: [
              SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset("assets/lottie/internet_error.json", height: 200, options: LottieOptions(enableMergePaths: true,)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          getSearchItem("", "", "");
                        },
                        child: const Text('Qayta urinib ko\'rish'),
                      )
                    ],
                  )
              )
            ],
          );
        },
      );
    }
    catch (e) {
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
    }finally {
      isLoading.value = false; // Reset the isLoading flag regardless of success or failure
      loadItem.value = false; // Set loadItem to false after the API call is complete
    }
  }
}



import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uy_joy_baraka/models/home_item.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetAllItemController extends GetxController {
  var loadItem = true.obs;
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
      if (!hasMoreData || isLoading) {
        return;
      }
      isLoading = true;

      var url = Uri.parse(
          '${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.home}?c_page=${page.value}&p_page=$limit');

      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        if (responseJson.containsKey('posts')) {
          if (page.value == 1) {
            allItem = (responseJson['posts'] as List)
                .map((e) => Posts.fromJson(e))
                .toList();
          } else {
            allItem.addAll((responseJson['posts'] as List)
                .map((e) => Posts.fromJson(e))
                .toList());
          }
          hasMoreData = (responseJson['posts'] as List).length == 10;
        } else {
          hasMoreData = false;
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
                        getAllItem();
                      },
                      child: const Text('Qayta urinib ko\'rish'),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      );
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
    } finally {
      isLoading =
          false;
      loadItem.value =
          false;
    }
  }
}

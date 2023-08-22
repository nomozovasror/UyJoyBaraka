import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/models/get_all_chats_model.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetAllChatsController extends GetxController {

  var loadItem = true.obs;
  List<Members> allChat = [];
  var page = 1.obs;
  int limit = 50;

  var isEmptyCheck = false.obs;


  @override
  void onInit() {
    getAllChats();
    super.onInit();
  }


  getAllChats() async {
    try {
      var url = Uri.parse('${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.getChats}');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json',
          'authorization': prefs.getString('token') ?? '',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        if (responseJson['ok'] == true) {
          allChat = (responseJson['members'] as List)
              .map((e) => Members.fromJson(e))
              .toList();
          print(allChat);
          if (allChat.isEmpty) {
            isEmptyCheck.value = true;
          }else{
            isEmptyCheck.value = false;
          }
          update();
        } else {
          throw jsonDecode(response.body)['message'] ?? 'Xato';
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } on SocketException catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
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
                          getAllChats();
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
    }finally {
      loadItem.value = false;
      update();
    }
  }

}
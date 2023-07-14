import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/pages/chat.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;


class PhoneCheckController extends GetxController {
  TextEditingController phoneCheckController = TextEditingController();


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> checkPhone() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.phoneCheck);
      Map body = {
        "phone": phoneCheckController.text,
      };

      http.Response response = await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200){
        final json = jsonDecode(response.body);
        if (json['ok'] == true){
          var phone = json['code'];
          print(phone);
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('phone', phone);
          phoneCheckController.clear();

          Get.off(ChatScreen());
        }else{
          throw jsonDecode(response.body)['message'] ?? 'Error';
        }
      }else{
        throw jsonDecode(response.body)['message'] ?? 'Error';
      }
    } catch (e) {
      Get.back();
      showDialog(context: Get.context!, builder: (context){
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
}
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;


class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> login() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.login);
      Map body = {
        "phone": phoneController.text,
        "password": passwordController.text,
      };

      http.Response response = await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 201){
        final json = jsonDecode(response.body);
        if (json['ok'] == true){
          var token = json['token'];
          if (kDebugMode) {
            print(token);
          }
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          phoneController.clear();
          passwordController.clear();

          Get.off(()=> const MyHomePage()) ;
        }else{
          throw jsonDecode(response.body)['message'] ?? 'Xato';
        }
      }else{
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } catch (e) {
      Get.back();
      showDialog(context: Get.context!, builder: (context){
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
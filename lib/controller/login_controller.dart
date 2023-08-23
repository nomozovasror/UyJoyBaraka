import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/check_phone.dart';
import 'package:uy_joy_baraka/controller/user_data_controller.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  GetUserDataController getUserDataController = Get.put(GetUserDataController());

  Future<void> login() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var url =
          Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.login);
      Map body = {
        "phone": phoneController.text,
        "password": passwordController.text,
      };

      http.Response response =
          await http.post(url, headers: headers, body: json.encode(body));
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {

        if (jsonResponse['ok'] == true || jsonResponse['confirm'] == true) {
          var token = jsonResponse['token'];
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          phoneController.clear();
          passwordController.clear();
          prefs.setBool('isLoggedIn', true);
          await likeController.restoreLikedDataFromAPI();
          Get.offAll(() => const MyHomePage());
          getUserDataController.getUserData();
        } else {
          throw jsonDecode(response.body)['message'] ?? 'Xato';
        }
      } else if(response.statusCode == 400 && jsonResponse['confirm'] == false){
        if (jsonResponse['ok'] != true) {
          try {
            var headerss = {
              'Content-Type': 'application/json',
            };
            var urlTwo = Uri.parse(
                ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.phoneCheck);
            Map bodyy = {
              "phone": phoneController.text,
            };
            http.Response responsee = await http.post(urlTwo,
                headers: headerss, body: json.encode(bodyy));
            if (responsee.statusCode == 200) {
              final jsonResponsee = jsonDecode(responsee.body);
              if (jsonResponsee['ok'] == true) {
                var code = jsonResponsee['code'];
                var codeValidationId = jsonResponsee['codeValidationId'];
                if (kDebugMode) {
                  print(jsonResponsee['massage'].toString());
                }
                final SharedPreferences prefs = await _prefs;

                await prefs.setString('code', code);
                await prefs.setString(
                    'code_validation_id', codeValidationId);
                phoneController.clear();
                passwordController.clear();

                Get.off(() => const CheckCode());
              } else {
                throw jsonResponsee['message'] ?? 'Xato';
              }
            } else {
              throw jsonDecode(responsee.body)['message'] ?? 'Xato';
            }
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        } else {
          throw jsonResponse['message'] ?? 'Xato';
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
    }
  }
}

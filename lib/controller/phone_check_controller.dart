import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/login_controller.dart';
import 'package:uy_joy_baraka/controller/user_data_controller.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CodeCheckController extends GetxController {
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  LoginController loginController = Get.put(LoginController());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var loading = false.obs;

  Future<void> checkCode(String code) async {
    try {
      loading.value = true;
      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'code-validation-id': prefs.getString('code_validation_id') ?? '',
      };
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.checkCode);
      Map body = {
        "code": code.toString(),
      };

      http.Response response =
          await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        if (json['ok'] == true) {
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          prefs.setBool('isLoggedIn', true);
          await likeController.restoreLikedDataFromAPI();
          loginController.phoneController.clear();
          loginController.passwordController.clear();
          TextEditingController().clear();
          Get.offAll(() => const MyHomePage());
          getUserDataController.getUserData();
        } else {
          throw jsonDecode(response.body)['message'] ?? 'Error';
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Error';
      }
    } catch (e) {
      loading.value = false;
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
    } finally {
      loading.value = false;
    }
  }
}

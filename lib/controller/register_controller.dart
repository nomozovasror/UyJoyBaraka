import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/check_phone.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class RegisterationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> register() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.register);
      Map body = {
        "name": nameController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
      };

      http.Response response =
          await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message'].toString());
        if (jsonResponse['ok'] == true) {
          try {
            var headerss = {
              'Content-Type': 'application/json',
            };
            var url_two = Uri.parse(
                ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.phoneCheck);
            Map bodyy = {
              "phone": phoneController.text,
            };
            http.Response responsee = await http.post(url_two,
                headers: headerss, body: json.encode(bodyy));

            if (responsee.statusCode == 200) {
              final jsonResponsee = jsonDecode(responsee.body);
              print(jsonResponsee.toString());
              if (jsonResponsee['ok'] == true) {
                var code = jsonResponsee['code'];
                print(jsonResponsee['massage'].toString());
                print(code);
                final SharedPreferences prefs = await _prefs;

                await prefs.setString('code', code);
                nameController.clear();
                phoneController.clear();
                passwordController.clear();

                Get.off(checkPhone());
              } else {
                throw jsonResponsee['message'] ?? 'Xato';
              }
            } else {
              throw jsonDecode(responsee.body)['message'] ?? 'Xato';
            }
          } catch (e) {
            print(e);
          }
        } else {
          throw jsonResponse['message'] ?? 'Xato';
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } catch (e) {
      Get.back();
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

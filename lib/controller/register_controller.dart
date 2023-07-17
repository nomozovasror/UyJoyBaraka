import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/check_phone.dart';
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
        if (kDebugMode) {
          print(jsonResponse['message'].toString());
        }
        if (jsonResponse['ok'] == true) {
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
                nameController.clear();
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

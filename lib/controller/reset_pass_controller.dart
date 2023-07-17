import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/check_phone.dart';
import 'package:uy_joy_baraka/auth/reset_pass.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ResetController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> resetPassword() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.phoneCheck);
      Map body = {
        "phone": phoneController.text,
      };

      http.Response response =
      await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['ok'] == true) {
          var code = jsonResponse['code'];
          var codeValidationId = jsonResponse['codeValidationId'];

          final SharedPreferences prefs = await _prefs;
          await prefs.setString('code', code);
          await prefs.setString('code_validation_id', codeValidationId);

          print(code);
          if (kDebugMode) {
            print(jsonResponse['message'].toString());
          }
          phoneController.clear();
          Get.to(() => ResetPass());
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



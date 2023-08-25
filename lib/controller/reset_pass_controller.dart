import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/reset_pass.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ResetController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var loading = false.obs;
  Future<void> resetPassword() async {
    try {
      loading.value = true;
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.phoneCheck);
      Map body = {
        "phone": "998${phoneController.text}",
      };
      http.Response response =
      await http.post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['ok'] == true) {
          var codeValidationId = jsonResponse['codeValidationId'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('code_validation_id', codeValidationId);
          if (kDebugMode) {
            print(jsonResponse['message'].toString());
          }
          Get.to(() => const ResetPass());
        } else {
          throw jsonResponse['message'] ?? 'Xato';
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } catch (e) {
      loading.value = false;
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
      loading.value = false;
    }
  }

  Future<void> sendCode() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.phoneCheck);
      Map body = {
        "phone": "998${phoneController.text}",
      };
      http.Response response =
      await http.post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['ok'] == true) {
          var codeValidationId = jsonResponse['codeValidationId'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('code_validation_id', codeValidationId);
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
          },);
    }
  }
}



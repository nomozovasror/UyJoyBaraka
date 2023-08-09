import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EditUserNameController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> editUserName() async {
    try {
      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'code-validation-id': prefs.getString('code_validation_id') ?? '',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.checkCode);
      Map body = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
      };
      var response = await http.patch(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print(jsonResponse['message'].toString());
        }
        if (jsonResponse['ok'] == true) {
          Get.back();
          Get.snackbar(
            'Success',
            jsonResponse['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            jsonResponse['message'].toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
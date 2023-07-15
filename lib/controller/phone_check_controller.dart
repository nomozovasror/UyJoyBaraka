import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;


class CodeCheckController extends GetxController {
  TextEditingController codeCheckController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> checkCode() async {
    try {
      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'code-validation-id': prefs.getString('code_validation_id') ?? '',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.checkCode);
      Map body = {
        "code": codeCheckController.text,
      };

      http.Response response = await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 201){
        final json = jsonDecode(response.body);
        if (json['ok'] == true){
          var token = json['token'];
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          codeCheckController.clear();

          Get.off(()=> const MyHomePage());
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
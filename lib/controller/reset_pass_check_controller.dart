import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/reset_pass_controller.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;


class ResetCodeCheckController extends GetxController {
  TextEditingController codeCheckController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ResetController resetController = Get.put(ResetController());

  Future<void> resetCheckCode() async {
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
          print(token);
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);


          try {
            final SharedPreferences prefs = await _prefs;
            var headers = {
              // 'Content-Type': 'application/json',
              'authorization': prefs.getString('token').toString(),
            };
            var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.resetPassword);
            Map body = {
              "password": resetController.confirmPasswordController.text.toString()
            };
            http.Response jsonResponse = await http.patch(url, headers: headers, body: body);

            if (jsonResponse.statusCode == 201){
              final json = jsonDecode(jsonResponse.body);
              if (json['ok'] == true){
                prefs.setBool('isLoggedIn', true);
                await likeController.restoreLikedDataFromAPI();
                Get.off(()=> const MyHomePage());
              }else{
                throw jsonDecode(jsonResponse.body)['message'] ?? 'Error';
              }
            }else{
              throw jsonDecode(jsonResponse.body)['message'] ?? 'Error';
            }
          } catch (e) {
            print(e.toString());
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
          codeCheckController.clear();
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
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/user_data_controller.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class EditPhoneController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> editPhone() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.checkPhone);

      Map body = {
        "phone": phoneController.text,
      };

      http.Response response =
          await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print(jsonResponse['message'].toString());
        }
        if (jsonResponse['exists'] == false) {
          try {
            final SharedPreferences prefs = await _prefs;
            var headers = {
              'Content-Type': 'application/json',
              'authorization': prefs.getString('token') ?? '',
            };
            Map body = {
              "phone": phoneController.text,
            };
            var url = Uri.parse(ApiEndPoints.BASE_URL +
                ApiEndPoints.authEndPoints.editUserPhone);
            http.Response response = await http.patch(url,
                headers: headers, body: json.encode(body));

            if (response.statusCode == 200) {
              final jsonResponse = jsonDecode(response.body);
              if (jsonResponse['ok'] == true) {
                Get.find<GetUserDataController>().getUserData();
                Get.back();
                Get.snackbar(
                  'Muvaffaqiyatli',
                  "Telefon raqam muvaffaqiyatli o'zgartirildi",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  forwardAnimationCurve: Curves.ease,
                  colorText: Colors.white,
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                  duration: const Duration(milliseconds: 2000),
                  animationDuration: const Duration(milliseconds: 500),
                );
              } else {
                Get.snackbar(
                  'Xato',
                  "Nimadir xato bo'ldi",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            }
          } catch (e) {
            if (kDebugMode) {
              print(e.toString());
            }
          }
        } else if (jsonResponse['exists'] == true) {
          Get.snackbar(
            'Xato',
            "Kechirasiz bu raqam ro'yxatdan o'tgan",
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFFF8D08),
            forwardAnimationCurve: Curves.ease,
            colorText: Colors.white,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            duration: const Duration(milliseconds: 2000),
            animationDuration: const Duration(milliseconds: 500),
          );
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
        },
      );
    }
  }

  Future<void> editName() async {
    try {
      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token') ?? '',
      };

      var url = Uri.parse(
          ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.editUserName);

      Map body = {
        "full_name": nameController.text,
      };

      http.Response response =
          await http.patch(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print(jsonResponse['message'].toString());
        }
        if (jsonResponse['ok'] == true) {
          Get.find<GetUserDataController>().getUserData();
          Get.back();
          Get.snackbar(
            'Muvaffaqiyatli',
            "Ism muvaffaqiyatli o'zgartirildi",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            forwardAnimationCurve: Curves.ease,
            colorText: Colors.white,
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            duration: const Duration(milliseconds: 2000),
            animationDuration: const Duration(milliseconds: 500),
          );
        }
      } else {
        Get.snackbar(
          'Xato',
          jsonDecode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFFF8D08),
          forwardAnimationCurve: Curves.ease,
          colorText: Colors.white,
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          duration: const Duration(milliseconds: 2000),
          animationDuration: const Duration(milliseconds: 500),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Xato',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFFF8D08),
        forwardAnimationCurve: Curves.ease,
        colorText: Colors.white,
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
        duration: const Duration(milliseconds: 2000),
        animationDuration: const Duration(milliseconds: 500),
      );
    }
  }
}

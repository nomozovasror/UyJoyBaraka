import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class GetUserDataController extends GetxController {
  late User user = User(
    userId: '',
    fullName: '',
    phone: '',
    role: '',
    userAttempts: 0,
    avatar: '',
    confirm: false,
    status: '',
    createdAt: '',
    updatedAt: '',
  );

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> getUserData() async {
    try {
      final SharedPreferences prefs = await _prefs;
      var url = Uri.parse(
          '${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.userData}');

      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token').toString(),
      };

      http.Response response = await http.get(
        url,headers: headers
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        user = User(
          userId: jsonData['user']['user_id'],
          fullName: jsonData['user']['full_name'],
          phone: jsonData['user']['phone'],
          role: jsonData['user']['role'],
          userAttempts: jsonData['user']['user_attempts'],
          avatar: jsonData['user']['avatar'],
          confirm: jsonData['user']['confirm'],
          status: jsonData['user']['status'],
          createdAt: jsonData['user']['created_at'],
          updatedAt: jsonData['user']['updated_at'],);
        update();
      }
      else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } on SocketException catch (e) {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Column(
              children: [
                Text('Sizda internet mavjud emas'),
                Text(
                  "Yoki server bilan bog'lanishda xatolik yuz berdi",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
            children: [
              SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset("assets/lottie/internet_error.json",
                            height: 200,
                            options: LottieOptions(
                              enableMergePaths: true,
                            )),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          getUserData();
                        },
                        child: const Text('Qayta urinib ko\'rish'),
                      ),
                      Text(e.toString(), style: const TextStyle(fontSize: 6, color: Colors.grey),)
                    ],
                  ))
            ],
          );
        },
      );
    }
  }

  deleteUserData(){
    user = User(
      userId: '',
      fullName: '',
      phone: '',
      role: '',
      userAttempts: 0,
      avatar: '',
      confirm: false,
      status: '',
      createdAt: '',
      updatedAt: '',
    );
    update();
  }
}

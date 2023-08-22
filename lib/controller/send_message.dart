import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/screens/chat_detail.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class SendMessageController extends GetxController {
  TextEditingController messageController = TextEditingController();

  Future<void> sendMessage(String chatId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'authorization': prefs.getString('token') ?? '',
      };

      Map body = {
        'message': messageController.text,
      };

      var url = Uri.parse("${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.getChats}/$chatId");

      http.Response response = await http.post(url, body: body, headers: headers);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['ok'] == true) {
        }
        messageController.clear();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class DeletePostController extends GetxController{
  Future<void> deletePost(announcementId) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token') ?? '',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.deletePost + announcementId.toString());

      http.Response response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print(jsonResponse['message'].toString());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
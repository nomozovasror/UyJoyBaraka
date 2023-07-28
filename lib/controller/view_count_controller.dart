
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ViewCounterController extends GetxController {
  Future<void> viewCounter(announcementId) async{
    try {
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.viewCounter + announcementId.toString());

      http.Response jsonResponse = await http.patch(url);
      print(jsonResponse.statusCode.toString());

    } catch (e) {
      print(e.toString());
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
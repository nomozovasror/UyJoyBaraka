import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ActivePost extends GetxController {
  Future<void> activePost(announcementId) async{
    try {
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.viewCounter + announcementId.toString());
      await http.patch(url);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
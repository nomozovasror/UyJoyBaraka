import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class ActivePostController extends GetxController {

  RxBool switchValue = RxBool(false);
  Future<void> activePost(announcementId) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token') ?? '',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.activePatch + announcementId.toString());

      http.Response response = await http.patch(url, headers: headers);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        switchValue.value = true;
      } else {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
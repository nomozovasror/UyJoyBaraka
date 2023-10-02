import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/models/ads_min_model.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetMinAdvertsDataController extends GetxController {
  var loadItem = false.obs;
  Ad? ad;

  @override
  void onInit() {
    getMinAdvertsData();
    super.onInit();
  }

  Future<void> getMinAdvertsData() async {
    try {
      loadItem.value = false;
      var url = Uri.parse(
          '${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.getAdvertBanner}');

      var headers = {
        'Content-Type': 'application/json',
      };

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        ad = Ad.fromJson(jsonData);
        print('ok: ${ad!.ok}');
        print('ads id: ${ad!.ads.id}');
        print('ads img_mob: ${ad!.ads.imgMob}');
        print('ads link: ${ad!.ads.link}');
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }finally{
      loadItem.value = true;
    }
  }
}

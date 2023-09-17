  import 'dart:convert';
  import 'package:flutter/foundation.dart';
  import 'package:get/get.dart';
  import 'package:uy_joy_baraka/models/advertising_model.dart';
  import 'package:uy_joy_baraka/utils/api_endpoints.dart';
  import 'package:http/http.dart' as http;

  class GetAdvertsDataController extends GetxController {

    List<Ads> allAds = [];
    var loadItem = false.obs;

    @override
    void onInit() {
      getAdvertsData();
      super.onInit();
    }

    Future<void> getAdvertsData() async {
      try {
        loadItem.value = false;
        var url = Uri.parse(
            '${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.getAdvert}');

        var headers = {
          'Content-Type': 'application/json',
        };

        http.Response response = await http.get(url, headers: headers);
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          allAds = (jsonData['ads'] as List)
              .map((e) => Ads.fromJson(e))
              .toList();
        } else {
          throw jsonDecode(response.body)['message'] ?? 'Xato';
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }finally{
        loadItem.value = true;
        print(loadItem.value);
      }
    }
  }

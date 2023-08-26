import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;


class UpdatePostController extends GetxController {

  final TextEditingController addressController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RxList<File>? selectedImages = RxList<File>();


  Future<void> pickImagesFromGallery() async {
    final ImagePicker picker = ImagePicker();
    List<XFile>? pickedFiles;

    try {
      pickedFiles = await picker.pickMultiImage(); // Use pickMultiImage() for multi-image selection
    } catch (e) {
      if (kDebugMode) {
        print('Error while picking the images: $e');
      }
    }

    if (pickedFiles != null) {
      selectedImages!.addAll(pickedFiles.map((file) => File(file.path)).toList()); // Update the RxList with new images
      update(); // Update the view to display selected images
    }
  }

  void removeImage(int index) {
    if (selectedImages != null && index >= 0 && index < selectedImages!.length) {
      selectedImages!.removeAt(index);
    }
  }

  Future<void> updatePost(String ijaravalue, String viloyat, String tuman, String valyuta, String announcementId) async {
    try {
      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token') ?? '',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.updatePost);

      var request = http.MultipartRequest('PATCH', url);

      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      request.fields['city'] = viloyat.toString();
      request.fields['district'] = tuman.toString();
      request.fields['address'] = addressController.text;
      request.fields['type'] = ijaravalue.toString();
      request.fields['title'] = titleController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['price'] = priceController.text;
      request.fields['price_type'] = valyuta.toString();
      request.fields['phone'] = phoneController.text;
      request.fields['announcement_id'] = announcementId.toString();


      for (int i = 0; i < selectedImages!.length; i++) {
        var imageFile = selectedImages![i];
        var multipartFile = http.MultipartFile.fromBytes('images', await imageFile.readAsBytes(), filename: imageFile.path.split('/').last);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['ok'] == true) {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('E\'lon muvaffaqiyatli yangilandi', textAlign: TextAlign.center,),
                children: [
                  SimpleDialogOption(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset("assets/lottie/success.json", height: 200, options: LottieOptions(enableMergePaths: true,)),
                          ),
                        ],
                      )
                  )
                ],
              );
            },
          );
          selectedImages!.clear();
        } else {
          throw jsonResponse['message'] ?? 'Xato';
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
}

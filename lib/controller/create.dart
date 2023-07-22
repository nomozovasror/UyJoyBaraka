import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uy_joy_baraka/main.dart';

import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;


class CreatePostController extends GetxController {

  TextEditingController addressController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RxList<File>? selectedImages = RxList<File>();


  Future<void> pickImagesFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? pickedFiles;

    try {
      pickedFiles = await _picker.pickMultiImage(); // Use pickMultiImage() for multi-image selection
    } catch (e) {
      print('Error while picking the images: $e');
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

  Future<void> createPost(String ijaravalue, String viloyat, String tuman, String valyuta) async {
    try {
      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token') ?? '',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.createPost);

      // Check if images are selected
      if (selectedImages == null || selectedImages!.isEmpty) {
        print('No images selected');
        return;
      }

      // Create a new multipart request
      var request = http.MultipartRequest('POST', url);

      // Set headers
      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      // Add the fields to the request
      request.fields['city'] = viloyat.toString();
      request.fields['district'] = tuman.toString();
      request.fields['address'] = addressController.text;
      request.fields['type'] = ijaravalue.toString();
      request.fields['title'] = titleController.text;
      request.fields['description'] = descriptionController.text;
      request.fields['price'] = priceController.text;
      request.fields['price_type'] = valyuta.toString();
      request.fields['phone'] = phoneController.text;

      // Add the images to the request
      for (int i = 0; i < selectedImages!.length; i++) {
        var imageFile = selectedImages![i];
        var multipartFile = http.MultipartFile.fromBytes('images', await imageFile.readAsBytes(), filename: imageFile.path.split('/').last);
        request.files.add(multipartFile);
      }

      // Send the request and get the response
      var streamedResponse = await request.send();

      // Get the response as a regular response
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['ok'] == true) {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('Muvaffaqiyatli saqlandi'),
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
          addressController.clear();
          titleController.clear();
          priceController.clear();
          phoneController.clear();
          descriptionController.clear();
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

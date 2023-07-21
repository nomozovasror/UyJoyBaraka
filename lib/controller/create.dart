import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CreatePostController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Function to select an image from the phone's memory
  Future<XFile?> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print('Error while picking the image: $e');
    }

    return pickedFile;
  }

  Future<void> createPost() async {
    try {
      final SharedPreferences prefs = await _prefs;
      var headers = {
        'Content-Type': 'application/json',
        'authorization': prefs.getString('token') ?? '',
      };
      var url = Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.authEndPoints.createPost);

      // Select an image from the gallery
      XFile? pickedImage = await pickImageFromGallery();

      // Check if an image was selected
      if (pickedImage == null) {
        print('No image selected');
        return;
      }

      // Fetch the image bytes from the selected file
      var imageBytes = await pickedImage.readAsBytes();

      // Create a new multipart request
      var request = http.MultipartRequest('POST', url);

      // Set headers
      headers.forEach((key, value) {
        request.headers[key] = value;
      });

      // Add the fields to the request
      request.fields['city'] = 'Surxondaryo';
      request.fields['district'] = 'Termiz';
      request.fields['address'] = 'Alisher Navoiy ko\'chasi';
      request.fields['type'] = 'sale';
      request.fields['title'] = 'TerDU sotiladi';
      request.fields['description'] = 'Tekingayam bervoraman';
      request.fields['price'] = '200000';
      request.fields['price_type'] = 'dollar';
      request.fields['phone'] = '998905210501';

      // Add the image to the request
      var multipartFile = http.MultipartFile.fromBytes('images', imageBytes, filename: pickedImage.path.split('/').last);
      request.files.add(multipartFile);

      // Send the request and get the response
      var streamedResponse = await request.send();

      // Get the response as a regular response
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['ok'] == true) {
          print("ok >>>>>>>>>>>>>>>>>>>>>>>");
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

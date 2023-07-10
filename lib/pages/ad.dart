import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageData {
  final File file;
  bool isUploading;
  bool uploadSuccess;

  ImageData({
    required this.file,
    this.isUploading = false,
    this.uploadSuccess = false,
  });
}

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({Key? key}) : super(key: key);

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  List<ImageData> selectedImages = [];
  String name = '';
  String expiration = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              selectImages();
            },
            child: Text("Select Images"),
          ),
          SizedBox(height: 16),
          Column(
            children: [
              for (int index = 0; index < selectedImages.length; index++)
                Column(
                  children: [
                    Image.file(
                      selectedImages[index].file,
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(height: 8),
                    if (selectedImages[index].isUploading)
                      CircularProgressIndicator(),
                    if (selectedImages[index].uploadSuccess)
                      Text(
                        'Uploaded successfully',
                        style: TextStyle(color: Colors.green),
                      ),
                    SizedBox(height: 16),
                  ],
                ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          SizedBox(height: 8),
          TextField(
            onChanged: (value) {
              setState(() {
                expiration = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Expiration',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              uploadImages();
            },
            child: Text("Upload Images"),
          ),
        ],
      ),
    );
  }

  Future selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      List<ImageData> newImages = [];
      for (File file in files) {
        newImages.add(
          ImageData(
            file: file,
          ),
        );
      }

      setState(() {
        selectedImages = newImages;
      });
    } else {
      print("No files selected.");
    }
  }

  Future uploadImages() async {
    var dio = Dio();

    setState(() {
      selectedImages.forEach((imageData) {
        imageData.isUploading = true;
      });
    });

    for (ImageData imageData in selectedImages) {
      try {
        String filename = imageData.file.path.split('/').last;

        FormData data = FormData.fromMap({
          'key': 'bbf33b20d1d6882d3ea88a8185a3a197',
          'image': await MultipartFile.fromFile(
            imageData.file.path,
            filename: filename,
          ),
          'name': name,
          'expiration': expiration,
        });

        var response = await dio.post(
          'https://api.imgbb.com/1/upload',
          data: data,
          onReceiveProgress: (int sent, int total) {
            // Progress can be tracked here if needed
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            imageData.isUploading = false;
            imageData.uploadSuccess = true;
          });
          print('Image uploaded successfully');
        } else {
          setState(() {
            imageData.isUploading = false;
            imageData.uploadSuccess = false;
          });
          print('Image upload failed');
        }
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          imageData.isUploading = false;
          imageData.uploadSuccess = false;
        });
      }
    }
  }
}

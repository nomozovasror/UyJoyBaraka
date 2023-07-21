import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/create.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

CreatePostController createPostController = Get.put(CreatePostController());
class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(onPressed: (){createPostController.pickImageFromGallery();}, child: Text("Pick Image"),),
          ElevatedButton(
            onPressed: () {
              createPostController.createPost();
            },
            child: Text("Upload Photo"),
          ),
        ],
      ),
    );

  }
}


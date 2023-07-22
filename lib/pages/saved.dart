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
var image = true.obs;

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () => createPostController.pickImagesFromGallery(),
            child: Text('Select Images'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text('Post'),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              return image.value ? _buildImageGridView() : Container();
            }),
          ),
        ],
      ),
    );
  }
  Widget _buildImageGridView() {
    if (createPostController.selectedImages == null || createPostController.selectedImages!.isEmpty) {
      return Center(
        child: Text('No images selected'),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: createPostController.selectedImages!.length,
        itemBuilder: (context, index) {
          final imageFile = createPostController.selectedImages![index];
          return Stack(
            children: [
              Image.file(imageFile),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () => createPostController.removeImage(index), // Call the removeImage function
                ),
              ),
            ],
          );
        },
      );
    }
  }
}

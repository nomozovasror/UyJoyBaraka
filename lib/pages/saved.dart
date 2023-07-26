import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/like_controller.dart';
import '../models/liked_posts.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  LikeController likeController = Get.put(LikeController());

  @override
  void initState() {
    super.initState();
    likeController.initializeLikedPostIds();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ListView.builder(
        itemCount: likeController.likedPosts.length,
        itemBuilder: (BuildContext context, int index) {
          final LikeModel post = likeController.likedPosts[index];
          return ListTile(
            title: Text(post.announcementTitle.toString()),
            subtitle: Text(post.announcementDescription.toString()),
            trailing: IconButton(
              onPressed: () async {
                // Unlike the post when IconButton is clicked
                await likeController.unlike(post.announcementId!);

                // Remove the unliked post from the list in the LikeController
                likeController.removeLikedPost(post.announcementId!);
                setState(() {});
              },
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}

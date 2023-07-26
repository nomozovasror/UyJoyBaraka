import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/like_controller.dart';
import '../models/liked_posts.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  // ...

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  LikeController likeController = Get.put(LikeController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: likeController.allLikedPost.length,
      itemBuilder: (BuildContext context, int index) {
        LikeModel post = likeController.allLikedPost[index];
        String postId = post.announcementId ?? '';

        return ListTile(
          title: Text(post.announcementTitle ?? ''),
          subtitle: Text(post.announcementDescription ?? ''),
          trailing: IconButton(
            onPressed: () {
              likeController.unlike(postId);
            },
            icon: Icon(
              likeController.isPostLiked(postId) ? Icons.favorite : Icons.favorite_border,
              color: likeController.isPostLiked(postId) ? Colors.red : null,
            ),
          ),
        );
      },
    );
  }
}

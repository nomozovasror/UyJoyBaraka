import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uy_joy_baraka/controller/like_controller.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  LikeController likeController = Get.put(LikeController());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
    itemCount: likeController.allLikedPost.length,
    itemBuilder: (BuildContext context, int index){
      return ListTile(
        title: Text(likeController.allLikedPost[index].announcementTitle.toString()),
        subtitle: Text(likeController.allLikedPost[index].announcementDescription.toString()),
        trailing: IconButton(
          onPressed: (){
            likeController.unlike(likeController.allLikedPost[index].announcementId);
          },
          icon: const Icon(Icons.delete),
        ),
      );
    },
    );
  }
}

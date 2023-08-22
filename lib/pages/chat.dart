import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/check_phone.dart';
import 'package:uy_joy_baraka/auth/login.dart';
import 'package:uy_joy_baraka/controller/get_active_post_controller.dart';
import 'package:uy_joy_baraka/controller/get_all_chats.dart';
import 'package:uy_joy_baraka/controller/get_messages.dart';
import 'package:uy_joy_baraka/controller/home_item_controller.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/screens/chat_detail.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

import '../controller/user_data_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  GetAllChatsController getAllChatsController = Get.put(GetAllChatsController());
  GetMessagesController getMessagesController = Get.put(GetMessagesController());

  String timeSlicer(time) {
    String timeSliced = time.substring(11, 16);
    return timeSliced.toString();
  }

  @override
  void initState() {
    super.initState();
    getAllChatsController.getAllChats();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if (getAllChatsController.loadItem.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }else{
        return ListView.builder(
            shrinkWrap: true,
            itemCount: getAllChatsController.allChat.length,
            itemBuilder: (context, index){
              final chat = getAllChatsController.allChat[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x19008b51),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1),
                    ],
                  ),
                  child: ListTile(
                    onTap: (){
                      getMessagesController.getMessage(chat.chatId.toString());
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetail(members: chat)));
                    },
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('${ApiEndPoints.BASE_URL}${chat.user!.avatar}'),
                    ),
                    title: Text(chat.user!.fullName.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    subtitle: Text(chat.message!.content.toString()),
                    trailing: Text(timeSlicer(chat.message!.timestamp.toString())),
                  ),
                ),
              );
            });
      }
    });
  }
}

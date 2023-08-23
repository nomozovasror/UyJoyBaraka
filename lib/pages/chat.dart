import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/controller/get_all_chats.dart';
import 'package:uy_joy_baraka/controller/get_messages.dart';
import 'package:uy_joy_baraka/screens/chat_detail.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GetAllChatsController getAllChatsController =
      Get.put(GetAllChatsController());
  GetMessagesController getMessagesController =
      Get.put(GetMessagesController());

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
    return Obx(() {
      if (getAllChatsController.loadItem.value == true) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: getAllChatsController.allChat.length,
            itemBuilder: (context, index) {
              final chat = getAllChatsController.allChat[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    getMessagesController.getMessage(chat.chatId.toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetail(members: chat)));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                          imageUrl: ApiEndPoints.BASE_URL +
                                  chat.user!.avatar.toString(),
                          imageBuilder: (context, imageProvider) => Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                          ),
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                color: Color(0xff008B51),
                          )),
                          errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                          ),
                        ),
                              ],
                            )),
                        const SizedBox(width: 10,),
                        Expanded(
                          flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 12,
                                  child: Text(
                                    chat.user!.fullName.toString(),
                                    style: const TextStyle(
                                        fontSize: 22, fontWeight: FontWeight.w500),
                                    maxLines: 1, overflow: TextOverflow.ellipsis
                                ),),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    timeSlicer(chat.message!.timestamp.toString()),
                                    style: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4,),
                            Text(chat.message!.content.toString(), maxLines: 1,
                              overflow: TextOverflow.ellipsis,),
                            const SizedBox(height: 4,)
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              );
            });
      }
    });
  }
}

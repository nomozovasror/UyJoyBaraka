import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/get_all_chats.dart';
import 'package:uy_joy_baraka/controller/get_messages.dart';
import 'package:uy_joy_baraka/controller/send_message.dart';
import 'package:uy_joy_baraka/controller/user_data_controller.dart';
import 'package:uy_joy_baraka/main.dart';
import 'package:uy_joy_baraka/models/get_all_chats_model.dart';
import 'package:uy_joy_baraka/models/meseeages_model.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class ChatDetail extends StatefulWidget {
  final Members members;
  const ChatDetail({Key? key, required this.members}) : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}


GetMessagesController getMessagesController = Get.put(GetMessagesController());
SendMessageController sendMessageController = Get.put(SendMessageController());
GetUserDataController getUserDataController = Get.put(GetUserDataController());

class _ChatDetailState extends State<ChatDetail> {
  String timeSlicer(time, start, end) {
    String timeSliced = time.substring(start, end);
    return timeSliced.toString();
  }

  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    getMessagesController.resetMessageStream(); // Reset the stream
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }


  final formKey = GlobalKey<FormState>();
  bool isMeCheck(index) {
    if (getMessagesController.messageList[index].senderId == prefs?.getString('userId')) {
      return true;
    } else {
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Image.asset('assets/images/logo.png', height: 40),
          backgroundColor: const Color(0xff008B51),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      '${ApiEndPoints.BASE_URL}${widget.members.user!.avatar}')
                              ),
                              const SizedBox(width: 10),
                              Text(widget.members.user!.fullName.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)
                            ],

                          ),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: "Chatni o'chirish",
                                content: const Text("Chatni o'chirishni xohlaysizmi?"),
                                textCancel: "Yo'q",
                                textConfirm: "Ha",
                                confirmTextColor: Colors.white,
                                cancelTextColor: Colors.red,
                                buttonColor: Colors.red,
                                onConfirm: (){
                                  getMessagesController.deleteChat(widget.members.chatId.toString());
                                  Navigator.pop(context);
                                  setState(() {
                                    Get.find<GetAllChatsController>().getAllChats();
                                    Get.close(0);
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/trash.svg'),
                                const Text(" Chatni o'chirish", style: TextStyle(color: Color(0xFFFF0000), fontSize: 16),)
                              ],
                            ),
                          )
                        ],),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                  ],
                )
            ),
            Expanded(
                child: StreamBuilder<List<MessagesList>>(
                  stream: getMessagesController.messageStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Sizda xabarlar yoq'));
                    } else {
                      return ListView.builder(
                        reverse: true, // This property reverses the list
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final reversedIndex = snapshot.data!.length - 1 - index;
                          final message = snapshot.data![reversedIndex];

                          final isMe = isMeCheck(reversedIndex);
                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 250,
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 3),
                                decoration: BoxDecoration(
                                  color: isMeCheck(reversedIndex) ? Colors.green : Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      message.content.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      timeSlicer(message.timestamp.toString(), 11, 16),
                                      style: TextStyle(
                                        color: Colors.grey[300],
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          );
                        },
                      );

                    }
                  },
                )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              padding: const EdgeInsets.only(left: 10, top: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: sendMessageController.messageController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Xabar yozish',
                    suffixIcon: IconButton(
                      disabledColor: Colors.cyan,
                      onPressed: () {
                        if (sendMessageController.messageController.text.isNotEmpty) {
                          sendMessageController
                              .sendMessage(widget.members.chatId.toString());
                          Future.delayed(const Duration(seconds: 1), () {
                            getMessagesController
                                .getMessage(widget.members.chatId.toString());
                          });
                        }
                      },
                      icon: const Icon(Icons.send, color: Color(0xFFFF8D08),),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
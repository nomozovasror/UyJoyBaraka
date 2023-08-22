import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/controller/get_messages.dart';
import 'package:uy_joy_baraka/controller/send_message.dart';
import 'package:uy_joy_baraka/models/meseeages_model.dart';

class ChatDetail extends StatefulWidget {
  final String? userId;
  final String? chatId;
  const ChatDetail({Key? key, required this.userId, this.chatId})
      : super(key: key);

  @override
  State<ChatDetail> createState() => _ChatDetailState();
}

GetMessagesController getMessagesController = Get.put(GetMessagesController());
SendMessageController sendMessageController = Get.put(SendMessageController());

class _ChatDetailState extends State<ChatDetail> {
  String timeSlicer(time) {
    String timeSliced = time.substring(0, 4);
    return timeSliced.toString();
  }

  bool isMeCheck(index) {
    if (getMessagesController.messageList[index].senderId == widget.userId) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    getMessagesController.resetMessageStream(); // Reset the stream
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
            Expanded(
                child: StreamBuilder<List<MessagesList>>(
              stream: getMessagesController.messageStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages available.'));
                } else {
                  return ListView.builder(
                    reverse: true, // This property reverses the list
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = snapshot.data!.length - 1 - index;
                      final message = snapshot.data![reversedIndex];
                      return Align(
                        alignment: isMeCheck(reversedIndex)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMeCheck(reversedIndex) ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(message.content.toString()),
                        ),
                      );
                    },
                  );

                }
              },
            )),
            Container(
              color: Colors.grey,
              child: TextField(
                controller: sendMessageController.messageController,
                decoration: InputDecoration(
                  hintText: 'Xabar yozish',
                  suffixIcon: IconButton(
                    onPressed: () {
                      sendMessageController
                          .sendMessage(widget.chatId.toString());
                      Future.delayed(const Duration(seconds: 1), () {
                        getMessagesController
                            .getMessage(widget.chatId.toString());
                      });
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

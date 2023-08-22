import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/models/meseeages_model.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;


class GetMessagesController extends GetxController {

  var loadItem = true.obs;
  List<MessagesList> messageList = [];
  late StreamController<List<MessagesList>> _messageStreamController;
  Stream<List<MessagesList>> get messageStream => _messageStreamController.stream;

  @override
  void onInit() {
    _messageStreamController = StreamController<List<MessagesList>>();
    super.onInit();
  }

  // Rest of your methods ...

  void resetMessageStream() {
    _messageStreamController.close();
    _messageStreamController = StreamController<List<MessagesList>>();
  }

  @override
  void dispose() {
    _messageStreamController.close();
    super.dispose();
  }


  Future<void> getMessage([String? chatId]) async {
    try {
      var url = Uri.parse('${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.getChats}/$chatId');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(url);

      http.Response response = await http.get(
        url,
        headers: {'Content-Type': 'application/json',
          'authorization': prefs.getString('token') ?? '',
        },
      );
      // print(response.body);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        if (responseJson['ok'] == true) {

          messageList = (responseJson['messages'] as List)
              .map((e) => MessagesList.fromJson(e))
              .toList();

          _messageStreamController.add(messageList);

          print(messageList[0].timestamp);
          print(messageList.length);
        } else {
          throw jsonDecode(response.body)['message'] ?? 'Xato';
        }
      } else {
        throw jsonDecode(response.body)['message'] ?? 'Xato';
      }
    } on SocketException catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Column(children: [
              Text('Sizda internet mavjud emas'),
              Text("Yoki server bilan bog'lanishda xatolik yuz berdi", style: TextStyle(fontSize: 12, color: Colors.grey),)
            ],),
            children: [
              SimpleDialogOption(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset("assets/lottie/internet_error.json", height: 200, options: LottieOptions(enableMergePaths: true,)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          getMessage(chatId);
                        },
                        child: const Text('Qayta urinib ko\'rish'),
                      )
                    ],
                  )
              )
            ],
          );
        },
      );
    }
    catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Xato'),
              children: [
                SimpleDialogOption(
                  child: Text(e.toString()),
                )
              ],
            );
          });
    }finally {
      loadItem.value = false;
      update();
    }
  }
  @override
  void onClose() {
    _messageStreamController.close();
    super.onClose();
  }

  Future<void> deleteChat(chatId) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'authorization': prefs.getString('token') ?? '',
      };
      var url = Uri.parse('${ApiEndPoints.BASE_URL}${ApiEndPoints.authEndPoints.getChats}/$chatId');
      http.Response response = await http.delete(url, headers: headers);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
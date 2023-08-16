import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/check_phone.dart';
import 'package:uy_joy_baraka/auth/login.dart';
import 'package:uy_joy_baraka/controller/get_active_post_controller.dart';
import 'package:uy_joy_baraka/controller/home_item_controller.dart';
import 'package:uy_joy_baraka/main.dart';

import '../controller/user_data_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  GetAllItemController getAllItemController = Get.put(GetAllItemController());
  GetUserDataController getUserDataController = Get.put(GetUserDataController());
  GetActivePostController getActivePostController =
      Get.put(GetActivePostController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                );
              },
              child: const Text('Auth screen  '),
            ),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs = await _prefs;
                print(prefs.getBool("isLoggedIn"));
                print(prefs.getString('token'));
              },
              child: const Text('Print token'),
            ),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs = await _prefs;
                prefs.clear();
                prefs.setBool('isLoggedIn', false);
                await likeController.deleteAllLikedData();
                getUserDataController.deleteUserData();
                Get.offAll(() => const MyHomePage());
                print(prefs.getString('token'));
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckCode()),
                );
              },
              child: Text("Code Check"),
            ),
            ElevatedButton(
              onPressed: () {
                getActivePostController.getActivePosts();
              },
              child: Text("print Active Posts"),
            ),
          ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/check_phone.dart';
import 'package:uy_joy_baraka/auth/login.dart';
import 'package:uy_joy_baraka/controller/home_item_controller.dart';
import 'package:uy_joy_baraka/main.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  GetAllItemController getAllItemController = Get.put(GetAllItemController());

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
                final SharedPreferences? prefs = await _prefs;
                print(prefs!.getString('token'));
              },
              child: const Text('Print token'),
            ),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences? prefs = await _prefs;
                prefs?.clear();
                Get.offAll(() => MyHomePage());
                print(prefs!.getString('token'));
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
                getAllItemController.getItemBySlug("zor-uy-sotiladi");
              },
              child: Text("Get item by slug"),
            ),
            Text("Item slug: ${getAllItemController.user!.phone}"),
          ]),
    );
  }
}

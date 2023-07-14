import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/phone_check_controller.dart';
import 'package:uy_joy_baraka/login.dart';

class checkPhone extends StatefulWidget {
  const checkPhone({Key? key}) : super(key: key);

  @override
  State<checkPhone> createState() => _checkPhoneState();
}
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

PhoneCheckController checkController = Get.put(PhoneCheckController());

class _checkPhoneState extends State<checkPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
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
                        print(prefs!.getString('code'));
                      },
                      child: const Text('Print token'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences? prefs = await _prefs;
                        prefs?.clear();
                        Get.offAll(AuthScreen());
                        print(prefs!.getString('token'));
                      },
                      child: const Text('Logout'),
                    ),
                  ]),
            ),
          )),
    );
  }
  Widget registerWidget() {
    return Column(
      children: [
        TextFormField(
          controller: checkController.phoneCheckController,
          decoration: InputDecoration(
            labelText: "Code",
            hintText: "Enter Code",
            border: OutlineInputBorder(),
          ),
        ),
        MaterialButton(
          onPressed: () {
            checkController.checkPhone();
          },
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
        ),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/phone_check_controller.dart';

class CheckCode extends StatefulWidget {
  const CheckCode({Key? key}) : super(key: key);

  @override
  State<CheckCode> createState() => _CheckCodeState();
}

CodeCheckController checkCodeController = Get.put(CodeCheckController());
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

var isCheck = true.obs;

class _CheckCodeState extends State<CheckCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome to Joy Baraka",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final SharedPreferences prefs = await _prefs;
                      if (kDebugMode) {
                        print(prefs.getString('code'));
                      }
                    },
                    child: const Text('Print token'),
                  ),
                  isCheck.value ? checkCodeWidget() : const Text("Nimadir xato ketti")
                ],
              ),),
            ),
          )),
    );
  }

  Widget checkCodeWidget() {
    return Column(
      children: [
        TextFormField(
          controller: checkCodeController.codeCheckController,
          decoration: const InputDecoration(
            labelText: "Code",
            hintText: "Enter Code",
            border: OutlineInputBorder(),
          ),
        ),
        MaterialButton(
          onPressed: () {
            checkCodeController.checkCode();
          },
          color: Colors.green,
          child: const Text(
            "Check Code",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

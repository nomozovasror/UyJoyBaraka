import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/edit_number_controller.dart';
import 'package:uy_joy_baraka/controller/user_delete_controller.dart';
import 'package:uy_joy_baraka/main.dart';

class EditUserDataScreen extends StatefulWidget {
  const EditUserDataScreen({Key? key}) : super(key: key);

  @override
  State<EditUserDataScreen> createState() => _EditUserDataScreenState();
}

EditPhoneController editPhoneController = EditPhoneController();
DeleteUserController deleteUserController = DeleteUserController();

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

final phoneKey = GlobalKey<FormState>();
final nameKey = GlobalKey<FormState>();

class _EditUserDataScreenState extends State<EditUserDataScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: phoneKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "phone_alert".tr;
                        } else if (value.length < 7) {
                          return "phone_short_seven".tr;
                        }
                        return null;
                      },
                      controller: editPhoneController.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Align(
                            widthFactor: 0.0,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5.0, left: 5.0),
                              child: Text(
                                "+998",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )),
                        suffixIcon: TextButton(
                          onPressed: (){
                            if (phoneKey.currentState!.validate()) {
                              editPhoneController.editPhone();
                            }
                          },
                          child: Text("save".tr, style: const TextStyle(color: Colors.blue),),
                        )
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: nameKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "name_alert".tr;
                        }
                        return null;
                      },
                      controller: editPhoneController.nameController,
                      decoration: InputDecoration(
                        hintText: 'name_hint'.tr,
                        suffixIcon: TextButton(
                          onPressed: (){
                            if (nameKey.currentState!.validate()) {
                              editPhoneController.editName();
                            }
                          },
                          child: Text('save'.tr, style: const TextStyle(color: Colors.blue),),
                        )
                      )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () {
                    if (Platform.isAndroid) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("delete_account_alert".tr),
                          content: Text("delete_account_text".tr, style: const TextStyle(color: Colors.red),),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("no".tr),
                            ),
                            TextButton(
                              onPressed: () async {
                                final SharedPreferences prefs = await _prefs;
                                prefs.clear();
                                prefs.setBool('isLoggedIn', false);
                                await likeController.deleteAllLikedData();
                                deleteUserController.deleteUser();
                                Get.offAll(() => const MyHomePage());
                              },
                              child: Text("yes".tr),
                            )
                          ],
                        ),
                      );
                    } else {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: Text("delete_account_alert".tr),
                          content: Text("delete_account_text".tr, style: const TextStyle(color: Colors.red),),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("no".tr),
                            ),
                            TextButton(
                              onPressed: () async {
                                final SharedPreferences prefs =
                                await _prefs;
                                prefs.clear();
                                prefs.setBool('isLoggedIn', false);
                                await likeController.deleteAllLikedData();

                                deleteUserController.deleteUser();
                                Get.offAll(() => const MyHomePage());
                              },
                              child: Text("yes".tr),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F3F2),
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset("assets/icons/exit.svg"),
                        Text(
                          "delete_account".tr,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff53B175)),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

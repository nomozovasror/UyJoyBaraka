import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/controller/login_controller.dart';
import 'package:uy_joy_baraka/controller/register_controller.dart';
import 'package:uy_joy_baraka/controller/reset_pass_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterationController registerationController =
      Get.put(RegisterationController());
  LoginController loginController = Get.put(LoginController());
  ResetController resetController = Get.put(ResetController());
  final _formKey = GlobalKey<FormState>();

  var isLogin = false.obs;
  var resetPass = true.obs;
  var _passwordVisible = false;
  var _passwordVisible2 = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _passwordVisible2 = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              IconButton(
                  onPressed: () {
                    if (!resetPass.value) {
                      setState(() {
                        resetPass.value = true;
                      });
                    } else {
                      Get.back();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios),),
              const SizedBox(
                height: 20,
              ),
              Text(isLogin.value ? "sign_up".tr : "sign_in".tr,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),),
              const SizedBox(
                height: 10,
              ),
              Text("input_pass_number".tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  )),
              const SizedBox(
                height: 30,
              ),
              isLogin.value ? registerWidget() : loginWidget()
            ],
          ),
        ),
      )),
    );
  }

  Widget registerWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("name_hint".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                )),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "name_alert".tr;
              }
              return null;
            },
            controller: registerationController.nameController,
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("phone".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                )),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "phone_alert".tr;
              } else if (value.length < 7) {
                return "phone_short_seven".tr;
              }
              return null;
            },
            controller: registerationController.phoneController,
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("password".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                )),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "password_alert".tr;
              } else if (value.length < 8) {
                return "password_short".tr;
              }
              return null;
            },
            keyboardType: TextInputType.text,
            controller: registerationController.passwordController,
            obscureText: !_passwordVisible2,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible2 ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible2 = !_passwordVisible2;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("password_confirm".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                )),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "password_alert".tr;
              } else if (value.length < 8) {
                return "password_short".tr;
              } else if (value != registerationController.passwordController.text) {
                return "password_confirm_alert".tr;
              }
              return null;
            },
            obscureText: !_passwordVisible2,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: const Color(0xff008b51)),
            child: TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registerationController.register();
                }
              },
              child: registerationController.loading.value ? const CircularProgressIndicator(color: Colors.white,) : Text(
                "sign_up".tr,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("account".tr),
              MaterialButton(
                onPressed: () {
                  isLogin.value = false;
                },
                child: Text(
                  "sign_in".tr,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loginWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("phone".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                )),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "input_pass_number".tr;
              } else if (value.length < 7) {
                return "phone_short_seven".tr;
              }
              return null;
            },
            controller: resetPass.value
                ? loginController.phoneController
                : resetController.phoneController,
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
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("password".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                )),
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "password_alert".tr;
              } else if (value.length < 8) {
                return "password_short".tr;
              }
              return null;
            },
            keyboardType: TextInputType.text,
            controller: loginController.passwordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          resetPass.value
              ? Container()
              : Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("password_confirm".tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "password_alert".tr;
                        } else if (value.length < 8) {
                          return "password_short".tr;
                        } else if (value !=
                            loginController.passwordController.text) {
                          return "password_confirm_alert".tr;
                        }
                        return null;
                      },
                      controller: resetController.confirmPasswordController,
                      obscureText: !_passwordVisible,
                    ),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              resetPass.value
                  ? TextButton(
                      onPressed: () {
                        if (Platform.isAndroid) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("reset_password_question".tr),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("no".tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    resetPass.value = false;
                                    Navigator.pop(context);
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
                              title: Text("reset_password_question".tr),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("no".tr),
                                ),
                                TextButton(
                                  onPressed: () {
                                    resetPass.value = false;
                                    Navigator.pop(context);
                                  },
                                  child: Text("yes".tr),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: Text("forgot_password".tr,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                          )))
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          resetPass.value
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: const Color(0xff008b51)),
                  child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          loginController.login();
                        }
                      },
                      child: loginController.loading.value ? const CircularProgressIndicator(color: Colors.white,) : Text(
                        "sign_in".tr,
                        style: const TextStyle(color: Colors.white),
                      )),
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      color: const Color(0xff008b51)),
                  child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          resetController.resetPassword();
                        }
                      },
                      child: resetController.loading.value ? const CircularProgressIndicator(color: Colors.white,) : Text(
                        "reset_password".tr,
                        style: const TextStyle(color: Colors.white),
                      )),
                ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("not_account".tr),
              MaterialButton(
                onPressed: () {
                  isLogin.value = true;
                  resetPass.value = true;
                },
                child: Text(
                  "sign_up".tr,
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

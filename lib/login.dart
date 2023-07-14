import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uy_joy_baraka/controller/login_controller.dart';
import 'package:uy_joy_baraka/controller/register_controller.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterationController registerationController =
      Get.put(RegisterationController());
  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;

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
                  Text(
                    "Welcome to Joy Baraka",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: isLogin.value
                                    ? Colors.black
                                    : Colors.green),
                          )),
                      TextButton(
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: isLogin.value
                                    ? Colors.green
                                    : Colors.black),
                          )),
                    ],
                  ),
                  isLogin.value ? loginWidget() : registerWidget(),
                ],
              ),),
        ),
      )),
    );
  }
  Widget registerWidget() {
    return Column(
      children: [
        TextFormField(
          controller: registerationController.nameController,
          decoration: InputDecoration(
            labelText: "Name",
            hintText: "Enter your name",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: registerationController.phoneController,
          decoration: InputDecoration(
            labelText: "Phone",
            hintText: "Enter your phone",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: registerationController.passwordController,
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () {
            registerationController.register();
          },
          child: Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?"),
            MaterialButton(
              onPressed: () {
                isLogin.value = true;
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        TextFormField(
          controller: loginController.phoneController,
          decoration: InputDecoration(
            labelText: "Phone",
            hintText: "Enter your phone",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: loginController.passwordController,
          decoration: InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () {
            loginController.login();
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?"),
            MaterialButton(
              onPressed: () {
                isLogin.value = false;
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ],
    );
  }

}

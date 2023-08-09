import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/controller/login_controller.dart';
import 'package:uy_joy_baraka/controller/register_controller.dart';
import 'package:uy_joy_baraka/controller/reset_pass_controller.dart';

class EditUserDataScreen extends StatefulWidget {
  const EditUserDataScreen({Key? key}) : super(key: key);

  @override
  State<EditUserDataScreen> createState() => _EditUserDataScreenState();
}

class _EditUserDataScreenState extends State<EditUserDataScreen> {

  final _formKey = GlobalKey<FormState>();

  var isLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome to Joy Baraka",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // isLogin.value ? loginWidget() : registerWidget(),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget editNameWidget() {
    return Column(
      children: [
        TextFormField(
          // controller: registerationController.nameController,
          decoration: const InputDecoration(
            labelText: "Name",
            hintText: "Enter your name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // controller: registerationController.phoneController,
          decoration: const InputDecoration(
            labelText: "Phone",
            hintText: "Enter your phone",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          // controller: registerationController.passwordController,
          decoration: const InputDecoration(
            labelText: "Password",
            hintText: "Enter your password",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () {
            // registerationController.register();
          },
          color: Colors.green,
          child: const Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account?"),
            MaterialButton(
              onPressed: () {
                isLogin.value = true;
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget loginWidget() {
  //   return Form(
  //     key: _formKey,
  //     child: Column(
  //       children: [
  //         resetPass.value
  //             ? Container()
  //             : IconButton(
  //           onPressed: () {
  //             resetPass.value = true;
  //           },
  //           icon: Icon(Icons.arrow_back),
  //         ),
  //         TextFormField(
  //           validator: (value) {
  //             if (value!.isEmpty) {
  //               return "Please enter your phone";
  //             }else if(value.length < 10){
  //               return "Please enter your phone";
  //             }
  //             return null;
  //           },
  //           controller: resetPass.value ? loginController.phoneController : resetController.phoneController,
  //           decoration: const InputDecoration(
  //             labelText: "Phone",
  //             hintText: "Enter your phone",
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         TextFormField(
  //           validator: (value) {
  //             if (value!.isEmpty) {
  //               return "Iltimos parolini kiriting";
  //             }else if(value.length < 5){
  //               return "Parol kamida 5 ta belgidan iborat bo'lishi kerak";
  //             }
  //             return null;
  //           },
  //           controller: loginController.passwordController,
  //           decoration: InputDecoration(
  //             labelText: "Password",
  //             hintText: "Enter your password",
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         resetPass.value
  //             ? Container()
  //             : TextFormField(
  //           validator: (value) {
  //             if (value!.isEmpty) {
  //               return "Iltimos parolini kiriting";
  //             }else if(value.length < 5){
  //               return "Parol kamida 5 ta belgidan iborat bo'lishi kerak";
  //             }else if(value != loginController.passwordController.text){
  //               return "Parol mos kelmadi";
  //             }
  //             return null;
  //           },
  //           controller: resetController.confirmPasswordController,
  //           decoration: InputDecoration(
  //             labelText: "Password",
  //             hintText: "Enter your password",
  //             border: OutlineInputBorder(),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             resetPass.value
  //                 ? TextButton(
  //               onPressed: () {
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) => AlertDialog(
  //                     title: Text("Parolni tiklamoqchimisiz"),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () {},
  //                         child: Text('Yo\'q'),
  //                       ),
  //                       TextButton(
  //                         onPressed: () {
  //                           resetPass.value = false;
  //                           Navigator.pop(context);
  //                         },
  //                         child: Text('Ha'),
  //                       )
  //                     ],
  //                   ),
  //                 );
  //               },
  //               child: Text("Parolni tiklash"),
  //             )
  //                 : Container(),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         resetPass.value
  //             ? MaterialButton(
  //           onPressed: () {
  //             if (_formKey.currentState!.validate()) {
  //               print("login >>>>>>>>>>>>>>>>");
  //               loginController.login();;
  //             }
  //           },
  //           color: Colors.green,
  //           child: Text(
  //             "Login",
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         )
  //             : MaterialButton(
  //           onPressed: () {
  //
  //             if (_formKey.currentState!.validate()) {
  //               print("reset >>>>>>>>>>>>>>>>");
  //               resetController.resetPassword();
  //             }
  //           },
  //           color: Colors.green,
  //           child: Text(
  //             "Parolni tiklash",
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text("Don't have an account?"),
  //             MaterialButton(
  //               onPressed: () {
  //                 isLogin.value = false;
  //               },
  //               child: Text(
  //                 "Register",
  //                 style: TextStyle(color: Colors.green),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

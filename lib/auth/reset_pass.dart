import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:uy_joy_baraka/controller/reset_pass_check_controller.dart';
import 'package:uy_joy_baraka/controller/reset_pass_controller.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final _formKey = GlobalKey<FormState>();

  ResetCodeCheckController resetCodeCheckController =
      Get.put(ResetCodeCheckController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: resetCodeCheckController.codeCheckController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Code";
                      } else if (value.length < 5) {
                        return "Code must be at least 5 characters";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      hintText: "Enter your phone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        resetCodeCheckController.resetCheckCode();
                      }
                    },
                    child: Text(
                      "CHeck Code",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

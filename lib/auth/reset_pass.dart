import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:uy_joy_baraka/controller/reset_pass_check_controller.dart';
import 'package:uy_joy_baraka/controller/reset_pass_controller.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {

  ResetCodeCheckController resetCodeCheckController =
      Get.put(ResetCodeCheckController());
  ResetController resetController = Get.put(ResetController());

  bool _onEditing = true;
  String? _codeReset;

  bool timer = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:[ Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios),),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Besh raqamli kodni kiriting",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Code",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: VerificationCode(
                    textStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
                    keyboardType: TextInputType.number,
                    underlineColor: Colors.green, // If this is null it will use primaryColor: Colors.red from Theme
                    length: 5,
                    cursorColor: Colors.blue, // If this is null it will default to the ambient
                    onCompleted: (String value) {
                      setState(() {
                        _codeReset = value;
                      });
                      resetCodeCheckController.resetCheckCode(_codeReset!);
                    },
                    onEditing: (bool value) {
                      setState(() {
                        _onEditing = value;
                      });
                      if (!_onEditing) FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ],
            ),

          ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      timer ? Countdown(
                        seconds: 90,
                        build: (BuildContext context, double time) {
                          return Text(
                            time.toInt().toString(),
                            style: const TextStyle(fontSize: 20, color: Colors.grey),
                          );
                        },
                        interval: const Duration(milliseconds: 1000),
                        onFinished: () {
                          setState(() {
                            timer = false;
                          });
                        },
                      ) : TextButton(onPressed: (){
                        resetController.sendCode();
                        setState(() {
                          timer = true;
                        });
                      }, child: const Text('Qayta yuborish',style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF53B175)),)),
                      FloatingActionButton(
                        backgroundColor: const Color(0xFF53B175),
                        elevation: 5,
                        onPressed: (){
                          if(_codeReset!.length == 5){
                            resetCodeCheckController.resetCheckCode(_codeReset!);
                          }
                        }, child: resetCodeCheckController.loading.value ? const CircularProgressIndicator(color: Colors.white,) : const Icon(Icons.arrow_forward_ios),),
                    ],
                  )
              ),
            )]
      ),
    );
  }
}

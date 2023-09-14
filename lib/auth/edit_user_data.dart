import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/controller/edit_number_controller.dart';

class EditUserDataScreen extends StatefulWidget {
  const EditUserDataScreen({Key? key}) : super(key: key);

  @override
  State<EditUserDataScreen> createState() => _EditUserDataScreenState();
}

EditPhoneController editPhoneController = EditPhoneController();

final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
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
                        if (formKey.currentState!.validate()) {
                          editPhoneController.editPhone();
                        }
                      },
                      child: Text("save".tr, style: const TextStyle(color: Colors.blue),),
                    )
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
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
                        if (formKey.currentState!.validate()) {
                          editPhoneController.editName();
                        }
                      },
                      child: Text('save'.tr, style: const TextStyle(color: Colors.blue),),
                    )
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                      return "Iltimos telefon raqamingizni kiriting";
                    } else if (value.length < 7) {
                      return "Telefon raqam 7 ta belgidan kam bo'lmasligi kerak";
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
                      child: const Text('Saqlash', style: TextStyle(color: Colors.blue),),
                    )
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Iltimos ism va familyangizni kiriting";
                    }
                    return null;
                  },
                  controller: editPhoneController.nameController,
                  decoration: InputDecoration(
                    hintText: 'Ism va familya',
                    suffixIcon: TextButton(
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                          editPhoneController.editName();
                        }
                      },
                      child: const Text('Saqlash', style: TextStyle(color: Colors.blue),),
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

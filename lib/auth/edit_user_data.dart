import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/edit_number_controller.dart';
import 'package:http/http.dart' as http;
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class EditUserDataScreen extends StatefulWidget {
  const EditUserDataScreen({Key? key}) : super(key: key);

  @override
  State<EditUserDataScreen> createState() => _EditUserDataScreenState();
}final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


GlobalKey _formKey = GlobalKey<FormState>();
EditPhoneController editPhoneController = EditPhoneController();




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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              TextFormField(
                controller: editPhoneController.phoneController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(onPressed: (){
                editPhoneController.editPhone();
              }, child: const Text('Save'),),

              TextFormField(
                controller: editPhoneController.nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(onPressed: (){
                editPhoneController.editName();
              }, child: const Text('Save'),),
            ],
          ),
        ),
      ),
    );
  }
}

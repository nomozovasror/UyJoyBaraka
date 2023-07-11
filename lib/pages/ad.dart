import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageData {
  final File file;
  bool isUploading;
  bool uploadSuccess;

  ImageData({
    required this.file,
    this.isUploading = false,
    this.uploadSuccess = false,
  });
}

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({Key? key}) : super(key: key);

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  List<ImageData> selectedImages = [];
  String name = '';
  String expiration = '';

  String ijaravalue = "Sotuv";

  final viloyatlar = [
    'Andijon',
    'Buxoro',
    'Farg\'ona',
    'Jizzax',
    'Xorazm',
    'Namangan',
    'Navoiy',
    'Qashqadaryo',
    'Qoraqalpog\'iston Respublikasi',
    'Samarqand',
    'Sirdaryo',
    'Surxondaryo',
    'Toshkent',
    'Toshkent shahri'
  ];

  final andijon = ['Andijon shaxri', 'Andijon tumani', 'Asaka', 'Baliqchi', 'Bo\'z', 'Buloqboshi', 'Izboskan', 'Jalaquduq', 'Marhamat', 'Oltinko\'l', 'Paxtaobod', 'Qo\'rg\'ontepa', 'Shahrixon', 'Ulug\'nor', 'Xo\'jaobod', 'Xonobod',];
  final buxoro = ['Buxoro shaxri', 'Buxoro tumani', 'G\'ijduvon', 'Jondor', 'Kogon', 'Qorako\'l', 'Qorovulbozor', 'Peshku', 'Romitan', 'Shofirkon', 'Vobkent',];
  final fargona = ['Oltiariq', 'Bag\'dod', 'Beshariq', 'Buvayda', 'Dang\'ara', 'Farg\'ona shaxri', 'Farg\'ona tumani', 'Furqat', 'Quva', 'Qo\'qon', 'Rishton', 'So\'x', 'Toshloq', 'Uchko\'prik', 'Yozyovon',];
  final jizzax = ['Arnasoy', 'Baxmal', 'Do\'stlik', 'Forish', 'G\'allaorol', 'G\'azalkent', 'Mirzacho\'l', 'Paxtakor', 'Yangiobod', 'Zomin', 'Zafarobod', 'Zarbdor', 'Zomin',];
  String? viloyat;
  String? andijon_value;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 30),
            child: Text(
              "E’lon joylash",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF008B51),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 5),
            child: Text(
              "Uy rasmini yuklang:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            height: 200,
            color: const Color(0x50008B51),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/fa_photo.svg", width: 65),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset("assets/icons/fa_photo.svg"),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset("assets/icons/fa_photo.svg", width: 65),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "+",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff008B51),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "Rasm yuklang",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff008B51),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      Text("Sarlavha kiriting",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(" *",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFF0707),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xffffffff),
                          hintText: "Masalan: olmazor uy arenda",
                          hintStyle: const TextStyle(
                              color: Color(0xffABABAB), fontSize: 14)),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      Text("Kategroiya",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(" *",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFF0707),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 6, top: 12, left: 8, right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: ijaravalue,
                        borderRadius: BorderRadius.circular(6),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        iconSize: 24,
                        style: const TextStyle(
                            color: Color(0xff272727),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        items: const [
                          DropdownMenuItem(
                            value: "Sotuv",
                            child: Text(
                              'Sotuv',
                              style: TextStyle(
                                  color: Color(0xffABABAB), fontSize: 16),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Ijara",
                            child: Text(
                              'Ijara',
                              style: TextStyle(
                                  color: Color(0xffABABAB), fontSize: 16),
                            ),
                          ),
                        ],
                        onChanged: (String? newIjara) {
                          setState(() {
                            ijaravalue = newIjara!;
                          });
                        }),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 25,
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      Text("Shaxarni tanlang",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(" *",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFF0707),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 6, top: 12, left: 8, right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: viloyat,
                      borderRadius: BorderRadius.circular(6),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      iconSize: 24,
                      style: const TextStyle(
                          color: Color(0xff272727),
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      items: viloyatlar.map(buildMenuItem).toList(),
                      onChanged: (viloyat) => setState(
                            () {
                          this.viloyat = viloyat!;
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 6, top: 12, left: 8, right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(6)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: ijaravalue,
                        borderRadius: BorderRadius.circular(6),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        iconSize: 24,
                        style: const TextStyle(
                            color: Color(0xff272727),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        items: const [
                          DropdownMenuItem(
                            value: "Sotuv",
                            child: Text(
                              'Sotuv',
                              style: TextStyle(
                                  color: Color(0xffABABAB), fontSize: 16),
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Ijara",
                            child: Text(
                              'Ijara',
                              style: TextStyle(
                                  color: Color(0xffABABAB), fontSize: 16),
                            ),
                          ),
                        ],
                        onChanged: (String? newIjara) {
                          setState(() {
                            ijaravalue = newIjara!;
                          });
                        }),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  Future selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      List<ImageData> newImages = [];
      for (File file in files) {
        newImages.add(
          ImageData(
            file: file,
          ),
        );
      }

      setState(() {
        selectedImages = newImages;
      });
    } else {
      print("No files selected.");
    }
  }

  Future uploadImages() async {
    var dio = Dio();

    setState(() {
      selectedImages.forEach((imageData) {
        imageData.isUploading = true;
      });
    });

    for (ImageData imageData in selectedImages) {
      try {
        String filename = imageData.file.path.split('/').last;

        FormData data = FormData.fromMap({
          'key': 'bbf33b20d1d6882d3ea88a8185a3a197',
          'image': await MultipartFile.fromFile(
            imageData.file.path,
            filename: filename,
          ),
          'name': name,
          'expiration': expiration,
        });

        var response = await dio.post(
          'https://api.imgbb.com/1/upload',
          data: data,
          onReceiveProgress: (int sent, int total) {
            // Progress can be tracked here if needed
            print("send >>>>> $sent\ntotal >>>>> $total");
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            imageData.isUploading = false;
            imageData.uploadSuccess = true;
          });
          print('Image uploaded successfully');
        } else {
          setState(() {
            imageData.isUploading = false;
            imageData.uploadSuccess = false;
          });
          print('Image upload failed');
        }
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          imageData.isUploading = false;
          imageData.uploadSuccess = false;
        });
      }
    }
  }
}

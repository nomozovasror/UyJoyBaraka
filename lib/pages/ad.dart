// ignore_for_file: prefer_is_empty, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/auth/login.dart';

import 'package:uy_joy_baraka/controller/create.dart';

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
  const AddAdScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  CreatePostController createPostController = Get.put(CreatePostController());

  String name = '';
  String expiration = '';

  final viloyatlar = [
    "Toshkent",
    "Andijon",
    "Buxoro",
    "Fargona",
    "Jizzax",
    "Xorazm",
    "Namangan",
    "Navoiy",
    "Qashqadaryo",
    "Qoraqalpogiston",
    "Samarqand",
    "Sirdaryo",
    "Surxondaryo",
  ];

  final andijon = [
    "Andijon shahri",
    "Andijon tumani",
    "Asaka tumani",
    "Baliqchi tumani",
    "Bo'z tumani",
    "Buloqboshi tumani",
    "Izboskan tumani",
    "Jalolquduq tumani",
    "Marhamat tumani",
    "Oltinko'l tumani",
    "Paxtaobod tumani",
    "Qo'rg'ontepa tumani",
    "Shahrixon tumani",
    "Ulug'nor tumani",
    "Xo'jaobod tumani",
    "Xonobod shahri",
  ];
  final buxoro = [
    "Buxoro shahri",
    "Buxoro tumani",
    "G'ijduvon tumani",
    "Jondor tumani",
    "Kogon shahri",
    "Kogon tumani",
    "Olot tumani",
    "Peshku tumani",
    "Qorako'l tumani",
    "Qorovulbozor tumani",
    "Romitan tumani",
    "Shofirkon tumani",
    "Vobkent tumani",
  ];
  final fargona = [
    "Farg'ona shahri",
    "Farg'ona tumani",
    "Beshariq tumani",
    "Bog'dod tumani",
    "Buvayda tumani",
    "Dang'ara tumani",
    "Furqat tumani",
    "Marg'ilon shahri",
    "O'zbekiston tumani",
    "Oltiariq tumani",
    "Qo'qon shahri",
    "Qo'shtepa tumani",
    "Quva tumani",
    "Quvasoy shahri",
    "Rishton tumani",
    "So'x tumani",
    "Toshloq tumani",
    "Uchko'prik tumani",
    "Yozyovon tumani",
  ];
  final jizzax = [
    "Jizzax shahri",
    "Jizzax tumani",
    "Arnasoy tumani",
    "Baxmal tumani",
    "Do'stlik tumani",
    "Forish tumani",
    "G'allaorol tumani",
    "Mirzacho'l tumani",
    "Paxtakor tumani",
    "Yangiobod tumani",
    "Zafarobod tumani",
    "Zarband tumani",
    "Zomin tumani",
  ];
  final xorazm = [
    "Bog'ot tumani",
    "Gurlan tumani",
    "Qo'shko'pir tumani",
    "Shovot tumani",
    "Urganch shahri",
    "Urganch tumani",
    "Xazorasp tumani",
    "Xiva tumani",
    "Xonqa tumani",
    "Yangiariq tumani",
    "Yangibozor tumani",
  ];
  final namangan = [
    "Namangan shahri",
    "Namangan tumani",
    "Chortoq tumani",
    "Chust tumani",
    "Kosonsoy tumani",
    "Mingbuloq tumani",
    "Norin tumani",
    "Pop tumani",
    "To'raqo'rg'on tumani",
    "Uchqo'rg'on tumani",
    "Uychi tumani",
    "Yangiqo'rgon tumani",
  ];
  final navoiy = [
    "Navoiy shahri",
    "Karmana tumani",
    "Konimex tumani",
    "Navbahor tumani",
    "Nurota tumani",
    "Qiziltepa tumani",
    "Tomdi tumani",
    "Uchquduq tumani",
    "Xatirchi tumani",
    "Zarafshon shahri",
  ];
  final qashqadaryo = [
    "Qarshi shahri",
    "Chiroqchi tumani",
    "Dehqonobod tumani",
    "G'uzor tumani",
    "Kasbi tumani",
    "Kitob tumani",
    "Koson tumani",
    "Mirishkor tumani",
    "Muborak tumani",
    "Nishon tumani",
    "Qamashi tumani",
    "Qarshi tumani",
    "Shahrisabz shahri",
    "Yakkabog' tumani",
  ];
  final qoraqalpogiston = [
    "Amudaryo tumani",
    "Beruniy tumani",
    "Chimboy tumani",
    "Ellikqala tumani",
    "Kegeyli tumani",
    "Mo'ynoq tumani",
    "Nukus shahri",
    "Nukus tumani",
    "Qonliko'l tumani",
    "Qorauzaq tumani",
    "Qung'irot tumani",
    "Shumanay tumani",
    "Taxiatosh shahri",
    "Taxtako'pir tumani",
    "To'rtko'l tumani",
    "Xo'jayli tumani",
  ];
  final samarqand = [
    "Samarqand shahri",
    "Samarqand tumani",
    "Bulung'ur tumani",
    "Ishtixon tumani",
    "Jomboy tumani",
    "Kattaqo'rg'on shahri",
    "Kattaqo'rg'on tumani",
    "Narpay tumani",
    "Nurobod tumani",
    "Oqdaryo tumani",
    "Past darg'om tumani",
    "Paxtachi tumani",
    "Poyariq tumani",
    "Qo'shrabot tumani",
    "Toyloq tumani",
    "Urgut tumani",
  ];
  final sirdaryo = [
    "Sirdaryo shari",
    "Boyovut tumani",
    "Guliston shahri",
    "Guliston tumani",
    "Oqoltin tumani",
    "Sardoba tumani",
    "Sayxunobod tumani",
    "Shirin shahri",
    "Sirdaryo tumani",
    "Xovos tumani",
    "Yangiyer shahri",
  ];
  final surxondaryo = [
    "Termiz shahri",
    "Angor tumani",
    "Bandixon tumani",
    "Boysun tumani",
    "Denov tumani",
    "Jarqo'rg'on tumani",
    "Muzrobot tumani",
    "Oltinsoy tumani",
    "Qiziriq tumani",
    "Qumqo'rg'on tumani",
    "Sariosiyo tumani",
    "Sherobod tumani",
    "Sho'rchi tumani",
    "Termiz tumani",
    "Uzun tumani",
  ];
  final toshkent = [
    "Toshkent shahri",
    "Bektemir tumani ",
    "Chilonzor tumani",
    "Mirzo Ulug'bek tumani",
    "Mirobod tumani",
    "Olmazor tumani",
    "Sergeli tumani",
    "Shayxontohur tumani",
    "Uchtepa tumani",
    "Yakkasaroy tumani",
    "Yashnobod tumani",
    "Yunusobod tumani",
    "Akmal-Abad tumani",
    "Bekabad tumani",
    "Qibray tumani",
    "Bo'ka tumani",
    "Bo'stonliq tumani",
    "Bo'zsu tumani",
    "Chinoz tumani",
    "Ohangaron tumani",
    "Oqqo'rg'on tumani",
    "Parkent tumani",
    "Piskent tumani",
    "Quyi Chirchiq tumani",
    "O'rta Chirchiq tumani",
    "Soh tumani",
    "Yangiyo'l tumani",
    "Yuqori Chirchiq tumani",
    "Zangiota tumani",
  ];
  final bosh = [''];

  String? sarlavha;
  String? ijaravalue;
  String? viloyat = 'Toshkent';
  String? tuman;
  String? manzil;
  String? text;
  String? narx;
  String? valyuta;
  String? tel;

  final _formKey = GlobalKey<FormState>();
  final _image = true.obs;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<bool>(
          future: getLoginStatus(),
          builder: (context, snapshot) {
            bool userLoggedIn = snapshot.data ?? false;
            return userLoggedIn
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 30),
                        child: Text(
                          "adAdd".tr,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF008B51),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20, bottom: 5),
                        child: Text(
                          "adPictureTitle".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Obx(() => _image.value
                          ? GestureDetector(
                              onTap: () {
                                createPostController.pickImagesFromGallery();
                              },
                              child: createPostController
                                          .selectedImages!.length >=
                                      1
                                  ? SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: createPostController
                                            .selectedImages!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          createPostController
                                                                  .selectedImages![
                                                              index]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: Stack(children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        3,
                                                                    vertical:
                                                                        2),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                            ),
                                                            child: Text(
                                                              "${index + 1}"
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        createPostController
                                                            .removeImage(index);
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ))
                                  : Container(
                                      height: 200,
                                      color: const Color(0x50008B51),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                  "assets/icons/fa_photo.svg",
                                                  width: 65),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/fa_photo.svg"),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/fa_photo.svg",
                                                  width: 65),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.add,
                                                  color: Color(0xff008B51)),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Text(
                                                "adPicture".tr,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff008B51),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                            )
                          : Container()),
                      Flexible(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                   Padding(
                                    padding: const EdgeInsets.only(
                                      top: 25,
                                      left: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text("adTitle".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Text(" *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFF0707),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Stack(children: [
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        controller: createPostController
                                            .titleController,
                                        validator: (sarlavha) {
                                          if (sarlavha!.isEmpty) {
                                            return "input_text".tr;
                                          }
                                          if (sarlavha.length < 10) {
                                            return "title_short".tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xffffffff),
                                            hintText: "hint_title".tr,
                                            hintStyle: const TextStyle(
                                                color: Color(0xffABABAB),
                                                fontSize: 14)),
                                      ),
                                    ]),
                                  ),
                                   Padding(
                                    padding: const EdgeInsets.only(
                                      top: 25,
                                      left: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text("category".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Text(" *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFF0707),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(
                                        bottom: 6, top: 12, left: 8, right: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                          hint: Text("sale_hint".tr),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          icon: const Icon(Icons
                                              .keyboard_arrow_down_outlined),
                                          iconSize: 24,
                                          style: const TextStyle(
                                              color: Color(0xff272727),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          items: [
                                            DropdownMenuItem(
                                              value: "sale",
                                              child: Text(
                                                "sale_hint".tr,
                                              ),
                                            ),
                                            DropdownMenuItem(
                                              value: "rent",
                                              child: Text(
                                                "rent".tr,
                                              ),
                                            ),
                                          ],
                                          onChanged: (ijaravalue) {
                                            setState(() {
                                              this.ijaravalue = ijaravalue!;
                                            });
                                          }),
                                    ),
                                  ),
                                   Padding(
                                    padding: const EdgeInsets.only(
                                      top: 25,
                                      left: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text("city_hint".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Text(" *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFF0707),
                                            ))
                                      ],
                                    ),
                                  ),

                                  //VILOYAT TANLANGANIDAN SO'NG TUMANLAR RO'YXATI CHIQADI
                                  Container(
                                    width: double.infinity,
                                    height: 60,
                                    margin: const EdgeInsets.only(
                                        bottom: 6, top: 12, left: 8, right: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
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
                                        hint: Text("hint_city".tr),
                                        borderRadius: BorderRadius.circular(6),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        iconSize: 24,
                                        style: const TextStyle(
                                            color: Color(0xff272727),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        items: viloyatlar
                                            .map(buildMenuViloyat)
                                            .toList(),
                                        onChanged: (viloyat) => setState(
                                          () {
                                            this.viloyat = viloyat!;
                                            tuman = null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  //TUMANLAR
                                  Container(
                                    height: 60,
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(
                                        bottom: 6, top: 12, left: 8, right: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(6)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: Text("district_hint".tr),
                                        value: tuman,
                                        borderRadius: BorderRadius.circular(6),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down_outlined),
                                        iconSize: 24,
                                        style: const TextStyle(
                                            color: Color(0xff272727),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        items: viloyat == "Andijon"
                                            ? andijon
                                                .map(buildMenuTuman)
                                                .toList()
                                            : viloyat == "Buxoro"
                                                ? buxoro
                                                    .map(buildMenuTuman)
                                                    .toList()
                                                : viloyat == "Fargona"
                                                    ? fargona
                                                        .map(buildMenuTuman)
                                                        .toList()
                                                    : viloyat == "Jizzax"
                                                        ? jizzax
                                                            .map(buildMenuTuman)
                                                            .toList()
                                                        : viloyat == "Xorazm"
                                                            ? xorazm
                                                                .map(
                                                                    buildMenuTuman)
                                                                .toList()
                                                            : viloyat ==
                                                                    "Namangan"
                                                                ? namangan
                                                                    .map(
                                                                        buildMenuTuman)
                                                                    .toList()
                                                                : viloyat ==
                                                                        "Navoiy"
                                                                    ? navoiy
                                                                        .map(
                                                                            buildMenuTuman)
                                                                        .toList()
                                                                    : viloyat ==
                                                                            "Qashqadaryo"
                                                                        ? qashqadaryo
                                                                            .map(
                                                                                buildMenuTuman)
                                                                            .toList()
                                                                        : viloyat ==
                                                                                "Qoraqalpogiston"
                                                                            ? qoraqalpogiston.map(buildMenuTuman).toList()
                                                                            : viloyat == "Samarqand"
                                                                                ? samarqand.map(buildMenuTuman).toList()
                                                                                : viloyat == "Sirdaryo"
                                                                                    ? sirdaryo.map(buildMenuTuman).toList()
                                                                                    : viloyat == "Surxondaryo"
                                                                                        ? surxondaryo.map(buildMenuTuman).toList()
                                                                                        : viloyat == "Toshkent"
                                                                                            ? toshkent.map(buildMenuTuman).toList()
                                                                                                : bosh.map(buildMenuTuman).toList(),
                                        onChanged: (tuman) => setState(
                                          () {
                                            this.tuman = tuman!;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  //MANZIL
                                   Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, bottom: 5),
                                    child: Row(
                                      children: [
                                        Text("adress".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Text(" *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFF0707),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Stack(children: [
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextFormField(
                                        controller: createPostController
                                            .addressController,
                                        validator: (manzil) {
                                          if (manzil!.isEmpty) {
                                            return "input_text".tr;
                                          } else if (manzil.length < 8) {
                                            return "adress_short".tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xffffffff),
                                            hintText: "adress_hint".tr,
                                            hintStyle: const TextStyle(
                                                color: Color(0xffABABAB),
                                                fontSize: 14)),
                                      ),
                                    ]),
                                  ),

                                  //UY HAQIDA MA"LUMOT
                                   Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, bottom: 5),
                                    child: Row(
                                      children: [
                                        Text("description".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Text(" *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFF0707),
                                            ),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 5,
                                                blurRadius: 8,
                                                offset: const Offset(
                                                  0,
                                                  3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          controller: createPostController
                                              .descriptionController,
                                          maxLines: 8,
                                          maxLength: 300,
                                          validator: (text) {
                                            if (text!.isEmpty) {
                                              return "input_text".tr;
                                            } else if (text.length < 10) {
                                              return "description_short".tr;
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xffffffff),
                                              hintText: "description_hint".tr,
                                              hintStyle: const TextStyle(
                                                  color: Color(0xffABABAB),
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // NARX
                                   Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, bottom: 5),
                                    child: Row(
                                      children: [
                                        Text("price".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Text(" *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFF0707),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Stack(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 22),
                                                height: 60,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.1),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: const Offset(
                                                        0,
                                                        3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              TextFormField(
                                                controller: createPostController
                                                    .priceController,
                                                validator: (narx) {
                                                  if (narx!.isEmpty) {
                                                    return "input_text".tr;
                                                  } else if (narx.length < 1) {
                                                    return "price_short".tr;
                                                  }
                                                  return null;
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      borderSide:
                                                          const BorderSide(
                                                        width: 0,
                                                        style: BorderStyle.none,
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xffffffff),
                                                    hintText: "1 6000 000",
                                                    hintStyle: const TextStyle(
                                                        color:
                                                            Color(0xffABABAB),
                                                        fontSize: 14)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            height: 60,
                                            margin: const EdgeInsets.only(
                                                left: 8, right: 4, bottom: 22),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffffffff),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                  value: valyuta,
                                                  hint: Text("sum".tr),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down_outlined),
                                                  iconSize: 24,
                                                  style: const TextStyle(
                                                      color: Color(0xff272727),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  items: [
                                                    DropdownMenuItem(
                                                      value: "sum",
                                                      child: Text(
                                                        "sum".tr,
                                                      ),
                                                    ),
                                                    DropdownMenuItem(
                                                      value: "dollar",
                                                      child: Text(
                                                        "dollar".tr,
                                                      ),
                                                    ),
                                                  ],
                                                  onChanged: (valyuta) {
                                                    setState(() {
                                                      this.valyuta = valyuta!;
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 10, bottom: 5),
                                    child: Row(
                                      children: [
                                        Text("phone".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        const Text(" *",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFF0707),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                          controller: createPostController
                                              .phoneController,
                                          validator: (tel) {
                                            if (tel!.isEmpty) {
                                              return "phone_alert".tr;
                                            } else if (tel.length < 10) {
                                              return "phone_short".tr;
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xffffffff),
                                              hintText: "998 00 123 45 67",
                                              hintStyle: const TextStyle(
                                                  color: Color(0xffABABAB),
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 90, vertical: 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (createPostController
                                                .selectedImages!.length <=
                                            0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                      "picture_alert".tr)
                                                ],
                                              ),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        } else if (ijaravalue == null ||
                                            ijaravalue == '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                      "category_alert".tr)
                                                ],
                                              ),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        } else if (tuman == null ||
                                            tuman == '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                      "district_alert".tr)
                                                ],
                                              ),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        } else if (valyuta == null ||
                                            valyuta == '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                             SnackBar(
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                      "valyuta_alert".tr)
                                                ],
                                              ),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        } else if (_formKey.currentState!
                                            .validate()) {
                                          createPostController.createPost(
                                              ijaravalue.toString(),
                                              viloyat.toString(),
                                              tuman.toString(),
                                              valyuta.toString());
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),
                                                  Text("save_progress".tr),
                                                ],
                                              ),
                                              backgroundColor:
                                                  Colors.greenAccent,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                      "all_input".tr)
                                                ],
                                              ),
                                              backgroundColor: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(200, 40),
                                        backgroundColor:
                                            const Color(0xffFF8D08),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                      ),
                                      child: Text("save".tr),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Lottie.asset('assets/lottie/login.json',
                            width: 200, height: 200),
                        Text(
                          "ad_login_alert".tr,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "ad_login_alert_text".tr,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AuthScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 40),
                            backgroundColor: const Color(0xFF53B175),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            child: Text("login".tr),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }

  DropdownMenuItem<String> buildMenuViloyat(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
  DropdownMenuItem<String> buildMenuTuman(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}

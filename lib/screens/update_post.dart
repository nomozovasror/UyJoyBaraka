// ignore_for_file: prefer_is_empty, avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uy_joy_baraka/controller/post_update_controller.dart';
import 'package:uy_joy_baraka/models/avtive_posts_model.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

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

class UpdatePostScreen extends StatefulWidget {
  final Active post;

  const UpdatePostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  String name = '';
  String expiration = '';

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

  final andijon = [
    'Andijon shaxri',
    'Andijon tumani',
    'Asaka',
    'Baliqchi',
    'Bo\'z',
    'Buloqboshi',
    'Izboskan',
    'Jalaquduq',
    'Marhamat',
    'Oltinko\'l',
    'Paxtaobod',
    'Qo\'rg\'ontepa',
    'Shahrixon',
    'Ulug\'nor',
    'Xo\'jaobod',
    'Xonobod',
  ];
  final buxoro = [
    'Buxoro shaxri',
    'Buxoro tumani',
    'G\'ijduvon',
    'Jondor',
    'Kogon',
    'Qorako\'l',
    'Qorovulbozor',
    'Peshku',
    'Romitan',
    'Shofirkon',
    'Vobkent',
  ];
  final fargona = [
    'Oltiariq',
    'Bag\'dod',
    'Beshariq',
    'Buvayda',
    'Dang\'ara',
    'Farg\'ona shaxri',
    'Farg\'ona tumani',
    'Furqat',
    'Quva',
    'Qo\'qon',
    'Rishton',
    'So\'x',
    'Toshloq',
    'Uchko\'prik',
    'Yozyovon',
  ];
  final jizzax = [
    'Arnasoy',
    'Baxmal',
    'Do\'stlik',
    'Forish',
    'G\'allaorol',
    'G\'azalkent',
    'Mirzacho\'l',
    'Paxtakor',
    'Yangiobod',
    'Zomin',
    'Zafarobod',
    'Zarbdor',
    'Zomin',
  ];
  final xorazm = [
    'Bog\'ot',
    'Gurlan',
    'Hazorasp',
    'Xiva',
    'Qo\'shko\'pir',
    'Shovot',
    'Urganch',
    'Xazorasp',
  ];
  final namangan = [
    'Chortoq',
    'Chust',
    'Kosonsoy',
    'Namangan shaxri',
    'Namangan tumani',
    'Pop',
    'To\'raqo\'rg\'on',
    'Uchqo\'rg\'on',
    'Uychi',
  ];
  final navoiy = [
    'Konimex',
    'Navbahor',
    'Navoiy shaxri',
    'Navoiy tumani',
    'Qiziltepa',
    'Xatirchi',
    'Zarafshon',
  ];
  final qashqadaryo = [
    'Dehqonobod',
    'G\'uzor',
    'Kasbi',
    'Kitob',
    'Koson',
    'Mirishkor',
    'Muborak',
    'Nishon',
    'Qamashi',
    'Qarshi',
    'Shahrisabz',
    'Yakkabog\'',
    'Yangiobod',
  ];
  final qoraqalpogiston = [
    'Amudaryo',
    'Beruniy',
    'Bo\'ston',
    'Chimboy',
    'Ellikqal\'a',
    'Kegeyli',
    'Mo\'ynoq',
    'Nukus',
    'Qanliko\'l',
    'Qo\'ng\'irot',
    'Qorao\'zak',
    'Shumanay',
    'Taxiatosh',
    'To\'rtko\'l',
    'Xo\'jayli',
  ];
  final samarqand = [
    'Bulung\'ur',
    'Ishtixon',
    'Jomboy',
    'Kattaqo\'rg\'on',
    'Narpay',
    'Nurobod',
    'Oqdaryo',
    'Payariq',
    'Pastdarg\'om',
    'Paxtachi',
    'Samarqand shaxri',
    'Samarqand tumani',
    'Toyloq',
    'Urgut',
  ];
  final sirdaryo = [
    'Boyovut',
    'Guliston',
    'G\'uliston',
    'Mirzaobod',
    'Oqoltin',
    'Sardoba',
    'Sirdaryo',
    'Xovos',
  ];
  final surxondaryo = [
    'Angor',
    'Boysun',
    'Denov',
    'Jarqo\'rg\'on',
    'Qiziriq',
    'Qumqo\'rg\'on',
    'Muzrabot',
    'Oltinsoy',
    'Sariosiyo',
    'Sherobod',
    'Sho\'rchi',
    'Termiz',
    'Uzun',
  ];
  final toshkent = [
    'Bekobod',
    'Bo\'ka',
    'Bo\'stonliq',
    'Chinoz',
    'Ohangaron',
    'Oqqo\'rg\'on',
    'Parkent',
    'Piskent',
    'Quyi chirchiq',
    'Toshkent shahri',
    'Toshkent tumani',
    'Yangiyo\'l',
    'Yuqori chirchiq',
  ];
  final toshkentShahri = [
    'Bektemir',
    'Chilonzor',
    'Mirobod',
    'Mirzo-Ulug\'bek',
    'Olmazor',
    'Sergeli',
    'Shayxontohur',
    'Uchtepa',
    'Yakkasaroy',
    'Yashnobod',
  ];
  final bosh = [''];

  String? sarlavha;
  String? ijaravalue;
  String? viloyat = 'Toshkent shahri';
  String? tuman;
  String? manzil;
  String? text;
  String? narx;
  String? valyuta;
  String? tel;

  final _formKey = GlobalKey<FormState>();
  final _image = true.obs;

  UpdatePostController controller = Get.put(UpdatePostController());

  @override
  void initState() {
    super.initState();
    controller.titleController.text = widget.post.title!;
    controller.descriptionController.text = widget.post.description!;
    controller.priceController.text = widget.post.price.toString();
    controller.phoneController.text = widget.post.phone!;
    controller.addressController.text = widget.post.address!;
    ijaravalue = widget.post.type!;
    viloyat = widget.post.city;
    tuman = widget.post.district;
    valyuta = widget.post.priceType;
  }

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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 30),
                child: Text(
                  "update_add".tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF008B51),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.post.thumb!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(ApiEndPoints.BASE_URL +
                                      widget.post.thumb![index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
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
                        controller.pickImagesFromGallery();
                      },
                      child: controller.selectedImages!.length >= 1
                          ? SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.selectedImages!.length,
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
                                                BorderRadius.circular(6),
                                            image: DecorationImage(
                                              image: FileImage(controller
                                                  .selectedImages![index]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Stack(children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 3,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Text(
                                                      "${index + 1}".toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white),
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
                                                controller.removeImage(index);
                                              });
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(50),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.add, color: Color(0xff008B51)),
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
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "update_picture_alert".tr,
                                    style: const TextStyle(
                                        color: Color(0xff008B51), fontSize: 12),
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
                            padding: const  EdgeInsets.only(
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: controller.titleController,
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
                                      borderRadius: BorderRadius.circular(6),
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
                                  hint: Text("sale_hint".tr),
                                  borderRadius: BorderRadius.circular(6),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined),
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
                                          "rent".tr
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
                                hint: Text("hint_city".tr),
                                borderRadius: BorderRadius.circular(6),
                                icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined),
                                iconSize: 24,
                                style: const TextStyle(
                                    color: Color(0xff272727),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                items:
                                    viloyatlar.map(buildMenuViloyat).toList(),
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                    ? andijon.map(buildMenuTuman).toList()
                                    : viloyat == "Buxoro"
                                        ? buxoro.map(buildMenuTuman).toList()
                                        : viloyat == "Farg'ona"
                                            ? fargona
                                                .map(buildMenuTuman)
                                                .toList()
                                            : viloyat == "Jizzax"
                                                ? jizzax
                                                    .map(buildMenuTuman)
                                                    .toList()
                                                : viloyat == "Xorazm"
                                                    ? xorazm
                                                        .map(buildMenuTuman)
                                                        .toList()
                                                    : viloyat == "Namangan"
                                                        ? namangan
                                                            .map(buildMenuTuman)
                                                            .toList()
                                                        : viloyat == "Navoiy"
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
                                                                        "Qoraqalpog'iston Respublikasi"
                                                                    ? qoraqalpogiston
                                                                        .map(
                                                                            buildMenuTuman)
                                                                        .toList()
                                                                    : viloyat ==
                                                                            "Samarqand"
                                                                        ? samarqand
                                                                            .map(
                                                                                buildMenuTuman)
                                                                            .toList()
                                                                        : viloyat ==
                                                                                "Sirdaryo"
                                                                            ? sirdaryo.map(buildMenuTuman).toList()
                                                                            : viloyat == "Surxondaryo"
                                                                                ? surxondaryo.map(buildMenuTuman).toList()
                                                                                : viloyat == "Toshkent"
                                                                                    ? toshkent.map(buildMenuTuman).toList()
                                                                                    : viloyat == "Toshkent shahri"
                                                                                        ? toshkentShahri.map(buildMenuTuman).toList()
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
                            padding:
                                const EdgeInsets.only(top: 25, left: 10, bottom: 5),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(children: [
                              Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: controller.addressController,
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
                                      borderRadius: BorderRadius.circular(6),
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
                            padding:
                                const EdgeInsets.only(top: 25, left: 10, bottom: 5),
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
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
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
                                  controller: controller.descriptionController,
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
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xffffffff),
                                      hintText: "description_hint".tr,                                      hintStyle: const TextStyle(
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 22),
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                        controller: controller.priceController,
                                        validator: (narx) {
                                          if (narx!.isEmpty) {
                                            return "input_text".tr;
                                          } else if (narx.length < 1) {
                                            return "price_short".tr;
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
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
                                            hintText: "1 6000 000",
                                            hintStyle: const TextStyle(
                                                color: Color(0xffABABAB),
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
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(6)),
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
                                              fontWeight: FontWeight.w400),
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
                            padding:
                                const EdgeInsets.only(top: 25, left: 10, bottom: 5),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Stack(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller: controller.phoneController,
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
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xffffffff),
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
                                if (ijaravalue == null || ijaravalue == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.error_outline,
                                            color: Colors.white,
                                          ),
                                          Text("category_alert".tr)
                                        ],
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                } else if (tuman == null || tuman == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.error_outline,
                                            color: Colors.white,
                                          ),
                                          Text("district_alert".tr)
                                        ],
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                } else if (valyuta == null || valyuta == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.error_outline,
                                            color: Colors.white,
                                          ),
                                          Text("valyuta_alert".tr)
                                        ],
                                      ),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                } else if (_formKey.currentState!.validate()) {
                                  controller.updatePost(
                                      ijaravalue.toString(),
                                      viloyat.toString(),
                                      tuman.toString(),
                                      valyuta.toString(),
                                      widget.post.announcementId!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                          Text("save_progress".tr)
                                        ],
                                      ),
                                      backgroundColor: Colors.greenAccent,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                backgroundColor: const Color(0xffFF8D08),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
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
          ),
        ),
      ),
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

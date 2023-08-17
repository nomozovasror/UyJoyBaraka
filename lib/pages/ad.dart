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
  const AddAdScreen({Key? key,}) : super(key: key);

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}
class _AddAdScreenState extends State<AddAdScreen> {


  CreatePostController createPostController = Get.put(CreatePostController());

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
        return userLoggedIn ? Column(
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
            Obx(() => _image.value ? GestureDetector(
              onTap: () {
                createPostController.pickImagesFromGallery();
              },
              child: createPostController.selectedImages!.length >= 1 ? SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: createPostController.selectedImages!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: DecorationImage(
                                  image: FileImage(createPostController.selectedImages![index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children:[ Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(3),
                                        ),
                                        child: Text("${index + 1}".toString(), style: const TextStyle(color: Colors.white),)),
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
                                    createPostController.removeImage(index);
                                  });
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
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
                  )
              ) : Container(
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
                      height: 16,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Color(0xff008B51)),
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
            ) : Container()),
            Flexible(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(children: [
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [ Container(
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
                              controller: createPostController.titleController,
                              validator: (sarlavha) {
                                if(sarlavha!.isEmpty) {
                                return 'Iltimos matn kiriting';
                                }
                                if(sarlavha.length < 10){
                                  return 'Sarlavha uzunligi yetarli emas';
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
                                  hintText: "Masalan: olmazor uy arenda",
                                  hintStyle: const TextStyle(
                                      color: Color(0xffABABAB), fontSize: 14)),
                            ),
  ]),
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
                              hint: const Text("Sotuv"),
                              borderRadius: BorderRadius.circular(6),
                              icon: const Icon(Icons.keyboard_arrow_down_outlined),
                              iconSize: 24,
                              style: const TextStyle(
                                  color: Color(0xff272727),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              items: const [
                                DropdownMenuItem(
                                  value: "sale",
                                  child: Text(
                                    'Sotuv',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "rent",
                                  child: Text(
                                    'Ijara',
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

                      //VILOYAT TANLANGANIDAN SO'NG TUMANLAR RO'YXATI CHIQADI
                      Container(width: double.infinity,
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
                            hint: const Text("Toshkent"),
                            borderRadius: BorderRadius.circular(6),
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
                            iconSize: 24,
                            style: const TextStyle(
                                color: Color(0xff272727),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            items: viloyatlar.map(buildMenuViloyat).toList(),
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
                            hint: const Text("Tumanni tanlang"),
                            value: tuman,
                            borderRadius: BorderRadius.circular(6),
                            icon: const Icon(Icons.keyboard_arrow_down_outlined),
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
                                ? fargona.map(buildMenuTuman).toList()
                                : viloyat == "Jizzax"
                                ? jizzax.map(buildMenuTuman).toList()
                                : viloyat == "Xorazm"
                                ? xorazm.map(buildMenuTuman).toList()
                                : viloyat == "Namangan" ? namangan.map(buildMenuTuman).toList()
                                : viloyat == "Navoiy" ? navoiy.map(buildMenuTuman).toList()
                                : viloyat == "Qashqadaryo"
                                ? qashqadaryo
                                .map(buildMenuTuman)
                                .toList()
                                : viloyat ==
                                "Qoraqalpog'iston Respublikasi"
                                ? qoraqalpogiston
                                .map(buildMenuTuman)
                                .toList()
                                : viloyat == "Samarqand"
                                ? samarqand
                                .map(
                                buildMenuTuman)
                                .toList()
                                : viloyat ==
                                "Sirdaryo"
                                ? sirdaryo
                                .map(
                                buildMenuTuman)
                                .toList()
                                : viloyat ==
                                "Surxondaryo"
                                ? surxondaryo
                                .map(
                                buildMenuTuman)
                                .toList()
                                : viloyat ==
                                "Toshkent"
                                ? toshkent
                                .map(
                                buildMenuTuman)
                                .toList()
                                : viloyat ==
                                "Toshkent shahri"
                                ? toshkentShahri
                                .map(
                                buildMenuTuman)
                                .toList()
                                : bosh
                                .map(buildMenuTuman)
                                .toList(),
                            onChanged: (tuman) => setState(
                                  () {
                                this.tuman = tuman!;
                              },
                            ),
                          ),
                        ),
                      ),

                      //MANZIL
                      const Padding(
                        padding: EdgeInsets.only(top: 25, left: 10, bottom: 5),
                        child: Row(
                          children: [
                            Text("Manzil",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          children: [Container(
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
                              controller: createPostController.addressController,
                              validator: (manzil) {
                                if(manzil!.isEmpty) {
                                return 'Iltimos matn kiriting';
                                }
                                else if(manzil.length < 8){
                                  return 'Manzil uzunligi yetarli emas';
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
                                  hintText: "Masalan: 17-mavze, 3-uy",
                                  hintStyle: const TextStyle(
                                      color: Color(0xffABABAB), fontSize: 14)),
                            ),
                       ] ),

                      ),

                      //UY HAQIDA MA"LUMOT
                      const Padding(
                        padding: EdgeInsets.only(top: 25, left: 10, bottom: 5),
                        child: Row(
                          children: [
                            Text("Uy haqida ma'lumot",
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
                              controller: createPostController.descriptionController,
                              maxLines: 8,
                              maxLength: 300,
                              validator: (text) {
                                if(text!.isEmpty) {
                                  return 'Iltimos matn kiriting';
                                }
                                else if(text.length < 10){
                                  return 'Matn juda kam';
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
                                  hintText:
                                  "Сдается в аренду для семьи трёхкомнатная квартира в центральном, спальном районе,на Дархане. Доброжелательные соседи,развитая  инфраструктура,в трёх минутах от метро Хамид Олимжан. Рядом  есть школа,детский сад.Квартира полностью оснащена для жилья: свежий ремонт, меблирована, детская будет обставлена по желанию жильцов,три телевизора,два кондиционера, большой холодильник, стиральная машина, пылесос. Техника, мебель и посуда новые,не пользованные. Вы будете первым хозяином. ",
                                  hintStyle: const TextStyle(
                                      color: Color(0xffABABAB), fontSize: 14)),
                            ),
                          ],
                        ),
                      ),

                      // NARX
                      const Padding(
                        padding: EdgeInsets.only(top: 25, left: 10, bottom: 5),
                        child: Row(
                          children: [
                            Text("Narxni kiriting",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 22),
                                    height: 60,
                                    width: MediaQuery.of(context).size.width - 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
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
                                    controller: createPostController.priceController,
                                    validator: (narx) {
                                      if(narx!.isEmpty) {
                                        return 'Iltimos narx kiriting';
                                      }
                                      else if(narx.length < 1){
                                        return 'narx kam';
                                      }
                                      return null;
                                    },
                                    // onChanged: (narx) {
                                    //   setState(() {
                                    //     this.narx = narx;
                                    //   });
                                    // },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
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
                                        hintText: "1 6000 000",
                                        hintStyle: const TextStyle(
                                            color: Color(0xffABABAB), fontSize: 14)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 60,
                                margin: const EdgeInsets.only(left: 8, right: 4, bottom: 22),
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
                                      value: valyuta,
                                      hint: const Text("so'm"),
                                      borderRadius: BorderRadius.circular(6),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined),
                                      iconSize: 24,
                                      style: const TextStyle(
                                          color: Color(0xff272727),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      items: const [
                                        DropdownMenuItem(
                                          value: "sum",
                                          child: Text(
                                            "so'm",
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: "dollar",
                                          child: Text(
                                            'dollar',
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
                      const Padding(
                        padding: EdgeInsets.only(top: 25, left: 10, bottom: 5),
                        child: Row(
                          children: [
                            Text("Telefon raqam",
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
                              controller: createPostController.phoneController,
                              validator: (tel) {
                                if(tel!.isEmpty) {
                                  return 'Iltimos telefon raqamingizni kiriting';
                                }
                                else if(tel.length < 10){
                                  return 'Telefon raqam uzunligi yetarli emas';
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
                                      color: Color(0xffABABAB), fontSize: 14)),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if (createPostController.selectedImages!.length <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Row(children: [
                                  Icon(Icons.error_outline ,color: Colors.white,),
                                  Text('  Iltimos surat yuklang')
                                ],),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                            else if (ijaravalue == null || ijaravalue == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Row(children: [
                                  Icon(Icons.error_outline ,color: Colors.white,),
                                  Text('  Iltimos kategoriyani tanlang')
                                ],),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                            else if (tuman == null || tuman == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Row(children: [
                                  Icon(Icons.error_outline ,color: Colors.white,),
                                  Text('  Iltimos tumanni tanlang')
                                ],),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                            else if (valyuta == null || valyuta == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Row(children: [
                                  Icon(Icons.error_outline ,color: Colors.white,),
                                  Text('  Iltimos valyuta tanlang')
                                ],),
                                  backgroundColor: Colors.redAccent,
                                ),
                              );
                            }
                              else if (_formKey.currentState!.validate()) {
                                createPostController.createPost(ijaravalue.toString(), viloyat.toString(), tuman.toString(), valyuta.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Row(children: [
                                Icon(Icons.check,color: Colors.white,),
                                Text('Saqlanmoqda ...')
                              ],),
                              backgroundColor: Colors.greenAccent,
                              ),
                              );
                              }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Row(children: [
                                  Icon(Icons.error_outline ,color: Colors.white,),
                                  Text('  Iltimos barcha qatorlarni to\'ldiring')
                                ],),
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
                          child: const Text("Saqlash"),
                        ),

                      ),
                    ],),
                  )
                ],
              ),
            )
          ],
        ) : Center(child:
          Column(children: [
            const SizedBox(height: 150,),
            Lottie.asset('assets/lottie/login.json', width: 200, height: 200),
            const Text('Iltimos avval tizimga kiring', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            const SizedBox(height: 10,),
            const Text("E'lon joylashingiz uchun avval tizimga kirishingiz yoki ro'yxatdan o'tishingiz kerak ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey), textAlign: TextAlign.center,),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
            },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
                backgroundColor: const Color(0xFF53B175),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Text('Kirish'),
            ),),
          ],),); }
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

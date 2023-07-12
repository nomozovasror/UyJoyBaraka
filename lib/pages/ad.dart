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
  String? viloyat;
  String? tuman;
  String? manzil;
  String? text;
  String? narx;
  String? valyuta = 'So\'m';
  String? tel;

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
                    height: 50,
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
                      onChanged: (sarlavha) {
                        setState(() {
                          this.sarlavha = sarlavha;
                        });
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
                            value: "Sotuv",
                            child: Text(
                              'Sotuv',
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Ijara",
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
                      hint: const Text("Chilonzor"),
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
                              : viloyat == "Farg\'ona"
                                  ? fargona.map(buildMenuTuman).toList()
                                  : viloyat == "Jizzax"
                                      ? jizzax.map(buildMenuTuman).toList()
                                      : viloyat == "Xorazm"
                                          ? xorazm.map(buildMenuTuman).toList()
                                          : viloyat == "Namangan"
                                              ? namangan
                                                  .map(buildMenuTuman)
                                                  .toList()
                                              : viloyat == "Qashqadaryo"
                                                  ? qashqadaryo
                                                      .map(buildMenuTuman)
                                                      .toList()
                                                  : viloyat ==
                                                          "Qoraqalpog\'iston Respublikasi"
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
                  child: Container(
                    height: 50,
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
                      onChanged: (manzil) {
                        setState(() {
                          this.manzil = manzil;
                        });
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
                  ),
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
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(
                            1,
                            -5,
                          ),
                        ),
                      ],
                    ),
                    child: TextField(
                      maxLines: 8,
                      maxLength: 300,
                      onChanged: (text) {
                        setState(() {
                          this.text = text;
                        });
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
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(
                                  0,
                                  3,
                                ),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (narx) {
                              setState(() {
                                this.narx = narx;
                              });
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
                                hintText: "1 6000 000",
                                hintStyle: const TextStyle(
                                    color: Color(0xffABABAB), fontSize: 14)),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.only(left: 8, right: 4),
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
                                value: valyuta,
                                hint: Text("So\'m"),
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
                                    value: "So\'m",
                                    child: Text(
                                      'So\'m',
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Dollar",
                                    child: Text(
                                      'Dollar',
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
                  child: Container(
                    height: 50,
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
                      onChanged: (tel) {
                        setState(() {
                          this.tel = tel;
                        });
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
                          hintText: "+998",
                          hintStyle: const TextStyle(
                              color: Color(0xffABABAB), fontSize: 14)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffFF8D08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text("Saqlash"),
                  ),
                )
              ],
            ),
          )
        ],
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

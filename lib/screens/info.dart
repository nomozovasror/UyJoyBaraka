// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/pages/home.dart';

import '../models.dart';
import '../pages/home.dart';

class InfoScreen extends StatefulWidget {
  final House house;

  const InfoScreen({Key? key, required this.house}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
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
              Stack(alignment: Alignment.center, children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                      height: 250,
                      viewportFraction: 1,
                      autoPlay: false,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index)),
                  itemCount: widget.house.img.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final imgL = widget.house.img[index];
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imgL), fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
                Positioned(
                    bottom: 10,
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: widget.house.img.length,
                      effect: const WormEffect(
                          dotWidth: 12,
                          dotHeight: 12,
                          activeDotColor: Color(0xffFF8D08),
                          dotColor: Colors.white),
                    ))
              ]),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("06.06.2023",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff666666))),
                    const Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_outlined,
                          size: 16,
                          color: Color(0xff666666),
                        ),
                        Text("223",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666))),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.only(right: 8, left: 12, top: 1),
                          decoration: const BoxDecoration(
                              color: Color(0xff008B51),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              )),
                          child: LikeButton(
                            size: 24,
                            isLiked: isLiked,
                            likeBuilder: (isTapped) {
                              return SvgPicture.asset(
                                'assets/icons/mdi_heart-outline.svg',
                                color: isTapped
                                    ? Colors.red
                                    : const Color(0xffffffff),
                              );
                            },
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 1, right: 10, left: 10),
                            decoration: const BoxDecoration(
                                color: Color(0xff008B51),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )),
                            child: SvgPicture.asset(
                              "assets/icons/system-uicons_forward.svg",
                              color: Colors.white,
                              width: 24,
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text("2 250 000 so’m",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff008B51))),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Olmazor tumanida joylashgan 2x kvartira ijaraga beriladi",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Сдается в аренду для семьи трёхкомнатная квартира в центральном, спальном районе,на Дархане. Доброжелательные соседи,развитая инфраструктура,в трёх минутах от метро Хамид Олимжан. Рядом  есть школа,детский сад.Квартира полностью оснащена для жилья: свежий ремонт, меблирована, детская будет обставлена по желанию жильцов,три телевизора,два кондиционера, большой холодильник, стиральная машина, пылесос. Техника, мебель и посуда новые,не пользованные. Вы будете первым хозяином. ",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff666666)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  maxLines: 8,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                      filled: true,
                      fillColor: const Color(0xffF1F1F1),
                      hintText: "Uy egasiga yozish",
                      hintStyle: const TextStyle(
                          color: Color(0xffABABAB), fontSize: 14)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          launch("tel:+998919998877");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff008B51),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_rounded,
                              size: 20,
                            ),
                            Text(
                              " Qo'ng'iroq qilish",
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFF8D08),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Yuborish ",
                              style: TextStyle(fontSize: 14),
                            ),
                            Icon(
                              Icons.send_outlined,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 100,
                color: const Color(0xffE3E3E3),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.house.img[0]),
                        radius: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Nasimov Mironshoh",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff898989)),
                          ),
                          Text("2019.14.08 dan beri ",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff898989)))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Siz uchun taklif",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff008B51))),
                  ],
                ),
              ),
              SizedBox(
                height: 332,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    final housex = houses[index];
                    return Container(
                      width: 200,
                      height: 330,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoScreen(house: housex,),),);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(housex.img[0]),
                                    fit: BoxFit.cover),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                              ),
                              height: 200,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Toshkent",
                                  style: TextStyle(
                                    color: Color(0xff666666),
                                  ),
                                ),
                                LikeButton(
                                  size: 24,
                                  isLiked: isLiked,
                                  likeBuilder: (isTapped) {
                                    return SvgPicture.asset(
                                      'assets/icons/mdi_heart-outline.svg',
                                      color: isTapped
                                          ? Colors.red
                                          : const Color(0xffFF8D08),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Padding(padding:  EdgeInsets.symmetric(
                              horizontal: 4, vertical: 6),
                            child: SizedBox(
                              child: Text('Olmazor tumanida joylashgan 2x kvartira ijaraga beriladi', style: TextStyle(fontSize: 12),maxLines: 2,
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ),
                          const Padding(padding:  EdgeInsets.symmetric(
                              horizontal: 4, vertical: 6),
                            child: SizedBox(
                              child: Text('2 250 000 so’m', style: TextStyle(fontSize: 18, color: Color(0xff008B51)),maxLines: 1,
                                overflow: TextOverflow.ellipsis,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14,)
            ],
          ),
        ),
      ),
    );
  }
}

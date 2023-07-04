// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  final imgList = [
    'assets/images/main.png',
    'assets/images/main.png',
    'assets/images/main.png',
  ];

  String? ijaravalue = "ijaraYokiSotuv";
  String? viloyat = "Toshkent";
  String? valyuta = "So'm";

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // FILTER >>>>>>>
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      bottom: 6, top: 12, left: 8, right: 4),
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff008B51), width: 1.5),
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
                            value: "ijaraYokiSotuv",
                            child: Text('Ijara yoki Sotuv'),
                          ),
                          DropdownMenuItem(
                            value: "Ijara",
                            child: Text('Ijara'),
                          ),
                          DropdownMenuItem(
                            value: "Sotuv",
                            child: Text('Sotuv'),
                          )
                        ],
                        onChanged: (String? newIjara) {
                          setState(() {
                            ijaravalue = newIjara!;
                          });
                        }),
                  ),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(
                      bottom: 6, top: 12, left: 4, right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff008B51), width: 1.5),
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
                        items: const [
                          DropdownMenuItem(
                            value: "Toshkent",
                            child: Text(
                              'Toshkent',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Andijon",
                            child: Text(
                              'Andijon',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Buxoro",
                            child: Text(
                              'Buxoro',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Fargʻona",
                            child: Text(
                              'Fargʻona',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Xorazm",
                            child: Text(
                              'Xorazm',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Namangan",
                            child: Text(
                              'Namangan',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Navoiy",
                            child: Text(
                              'Navoiy',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Qashqadaryo",
                            child: Text(
                              'Qashqadaryo',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Qoraqalpogʻiston",
                            child: Text(
                              'Qoraqalpogʻiston',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Samarqand",
                            child: Text(
                              'Samarqand',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Sirdaryo",
                            child: Text(
                              'Sirdaryo',
                              softWrap: true,
                            ),
                          ),
                          DropdownMenuItem(
                            value: "Surxondaryo",
                            child: Text(
                              'Surxondaryo',
                              softWrap: true,
                            ),
                          ),
                        ],
                        onChanged: (String? newViloyat) {
                          setState(() {
                            viloyat = newViloyat!;
                          });
                        }),
                  ),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(
                      bottom: 6, top: 12, left: 4, right: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff008B51), width: 1.5),
                      borderRadius: BorderRadius.circular(6)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: valyuta,
                        borderRadius: BorderRadius.circular(6),
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        iconSize: 24,
                        style: const TextStyle(
                            color: Color(0xff272727),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        items: const [
                          DropdownMenuItem(
                            value: "So'm",
                            child: Text("So'm"),
                          ),
                          DropdownMenuItem(
                            value: "Dollar",
                            child: Text('Dollar'),
                          ),
                          DropdownMenuItem(
                            value: "Yevro",
                            child: Text('Yevro'),
                          )
                        ],
                        onChanged: (String? newValyuta) {
                          setState(() {
                            valyuta = newValyuta!;
                          });
                        }),
                  ),
                ),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(
                      bottom: 6, top: 12, left: 4, right: 4),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff008B51),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                    ),
                    child: const Text("Izlash"),
                  ),
                )
              ],
            ),
          ),
          // CAROUSEL >>>>>>>>
          Stack(alignment: Alignment.center, children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                  height: 250,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index)),
              itemCount: imgList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final imgL = imgList[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imgL), fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0x40008B51),
                            Color(0x40000000),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 42,
                          left: 28,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 300,
                                child: Text(
                                  "Uy-joy e’lonlaringizni bizning saytga joylashtiring",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  launch("tel:+998919998877");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff008B51),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.phone_rounded,
                                      size: 20,
                                    ),
                                    Text(
                                      " Biz bilan bog'lanish",
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
                bottom: 10,
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: imgList.length,
                  effect: const WormEffect(
                      dotWidth: 12,
                      dotHeight: 12,
                      activeDotColor: Color(0xffFF8D08),
                      dotColor: Colors.white),
                ))
          ]),
          // TITLE
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: const Row(
              children: [
                Text("Sizga mos keladigan uylar",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff008B51))),
              ],
            ),
          ),
          Flexible(
              child:StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: 26,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if ((index + 1) % 11 == 0) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: 260,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/ad_img.jpg",)
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 42,
                            left: 28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 300,
                                  child: Text(
                                    "REKLAMANGIZ UCHUN\nJOY",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff008B51)),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    launch("tel:+998919998877");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff008B51),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.phone_rounded,
                                        size: 20,
                                      ),
                                      Text(
                                        " Biz bilan bog'lanish",
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ); //your required widget
                  } else { //for odd row
                    return Container(
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
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/card_img.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8)),
                            ),
                            height: 200,
                            width: double.infinity,
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
                  }
                },
                staggeredTileBuilder: (int index) => (index + 1)% 11 == 0
                    ? const StaggeredTile.fit(2)
                    : const StaggeredTile.fit(1),
              ),
          ),
        ],
      ),
    );
  }
}

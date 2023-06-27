// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
                    image: AssetImage(imgL),fit: BoxFit.cover
                  ),
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
                              onPressed: ()  {
                                launch("tel:+998919998877");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff008B51),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6)
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.phone_rounded, size: 20,),
                                  Text(" Biz bilan bog'lanish",style: TextStyle(fontSize: 14),)
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
      ],
    );
  }
}

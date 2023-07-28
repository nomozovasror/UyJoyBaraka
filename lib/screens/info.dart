// ignore_for_file: deprecated_member_use

import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/controller/home_item_controller.dart';
import 'package:uy_joy_baraka/models/home_item.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class InfoScreen extends StatefulWidget {
  final Posts allData;

  const InfoScreen({Key? key, required this.allData}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  int activeIndex = 0;

  GetAllItemController getAllItemController = Get.put(GetAllItemController());
  String timeSlicer(time) {
    String timeSliced = time.substring(0, 10);
    return timeSliced.toString();
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
            children: [
              Stack(alignment: Alignment.center, children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.width,
                      viewportFraction: 1,
                      autoPlay: false,
                      onPageChanged: (index, reason) =>
                          setState(() => activeIndex = index)),
                  itemCount: widget.allData.thumb!.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    final imgL = Uri(
                        scheme: 'http',
                        host: 'test.uyjoybaraka.uz',
                        path: widget.allData.thumb![index]);

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: imgL.toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff008B51),
                        )),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                    bottom: 10,
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: widget.allData.thumb!.length,
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
                    Text(timeSlicer(widget.allData.createdAt!),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff666666))),
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 16,
                          color: Color(0xff666666),
                        ),
                        Text(widget.allData.viewCount.toString(),
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),),),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              right: 8, left: 12, top: 3, bottom: 3),
                          decoration: const BoxDecoration(
                              color: Color(0xff008B51),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              )),

                        ),
                        Container(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, top: 3, bottom: 3),
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("${widget.allData.price.toString()} ${widget.allData.priceType == 'dollar' ? '\$' : 'so\'m'}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff008B51))),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.allData.title.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.allData.description.toString(),
                        style: const TextStyle(
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
                          launch("tel:+${widget.allData.phone}");
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
                        backgroundImage: NetworkImage(ApiEndPoints.BASE_URL + widget.allData.avatar
                            .toString().replaceAll("https", "http",),),
                        radius: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.allData.fullName.toString(),
                            style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff898989)),
                          ),

                          Text("${timeSlicer(widget.allData.createdAt.toString())} dan beri",
                              style: const TextStyle(
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
                    Text(
                      "Siz uchun taklif",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff008B51),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 342,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: getAllItemController.allItem.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InfoScreen(
                                    allData: getAllItemController
                                        .allItem[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                              ),
                              height: 200,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageBuilder: (context, imageProvider) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.cover),
                                  ),
                                ),
                                imageUrl: ApiEndPoints.BASE_URL + getAllItemController
                                    .allItem[index].thumb![0].toString().replaceAll("https", "http",),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff008B51),
                                    )),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    getAllItemController.allItem[index].city!,
                                    style: const TextStyle(
                                      color: Color(0xff666666),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            child: SizedBox(
                              height: 30,
                              child: Text(
                                getAllItemController.allItem[index].title!,
                                style: const TextStyle(fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            child: SizedBox(
                              child: Text(
                                "${getAllItemController.allItem[index].price!} ${getAllItemController.allItem[index].priceType! == 'dollar' ? '\$' : 'so\'m'}",
                                style: const TextStyle(
                                    fontSize: 18, color: Color(0xff008B51)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}

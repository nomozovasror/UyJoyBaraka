// ignore_for_file: deprecated_member_use

import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/controller/chat_info_send_controller.dart';
import 'package:uy_joy_baraka/controller/home_item_controller.dart';
import 'package:uy_joy_baraka/controller/like_controller.dart';
import 'package:uy_joy_baraka/models/liked_posts.dart';
import 'package:uy_joy_baraka/pages/saved.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

import '../main.dart';

class LikedInfoScreen extends StatefulWidget {
  final LikeModel allData;

  const LikedInfoScreen({Key? key, required this.allData}) : super(key: key);

  @override
  State<LikedInfoScreen> createState() => _LikedInfoScreenState();
}

class _LikedInfoScreenState extends State<LikedInfoScreen> {
  int activeIndex = 0;

  LikeController likeController = Get.put(LikeController());
  GetAllItemController getAllItemController = Get.put(GetAllItemController());

  String timeSlicer(time) {
    String timeSliced = time.substring(0, 10);
    return timeSliced.toString();
  }
  bool isLiked = false;

  Future<void> _toggleLikeStatus(String postId) async {
    if (likeController.isPostLiked(postId)) {
      await _unlikePost(postId);
    } else {
      await _likePost(postId);
    }
  }

  // Function to perform like operation
  Future<void> _likePost(String postId) async {
    await likeController.like(postId);
    await likeController.fetchAndStoreLikedPosts();
    await likeController
        .getAllLikedPosts();
    likeController.updateLikedPosts(likeController.allLikedPost);
  }

  Future<void> _unlikePost(String postId) async {
    await likeController.unlike(postId);
    await likeController.fetchAndStoreLikedPosts();
    await likeController.getAllLikedPosts();
    likeController.removeLikedPost(postId);
    likeController.updateLikedPosts(likeController.allLikedPost);
  }

  @override
  void initState() {
    super.initState();
    likeController.initializeLikedPostIds();
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  final _formKey = GlobalKey<FormState>();
  InChatMessageController inChatMessageController = Get.put(InChatMessageController());

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
                  itemCount: widget.allData.announcementThumb!.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                        final imgL = ApiEndPoints.BASE_URL + widget.allData.announcementThumb![index].toString();
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
                      count: widget.allData.announcementThumb!.length,
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
                        Text(widget.allData.announcementViewCount.toString(),
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
                              right: 8, left: 12, top: 3, bottom: 7),
                          decoration: const BoxDecoration(
                              color: Color(0xff008B51),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),),
                            child: FutureBuilder<bool>(
                                future: getLoginStatus(),
                                builder: (context, snapshot) {
                                  bool userLoggedIn = snapshot.data ?? false;
                              return LikeButton(
                                size: 20,
                                circleColor: const CircleColor(
                                    start: Color(0xff00ddff),
                                    end: Color(0xff0099cc)),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xff33b5e5),
                                  dotSecondaryColor: Color(0xff0099cc),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    likeController.isPostLiked(widget.allData.announcementId!) ? Icons.favorite : Icons.favorite_border,
                                    color: const  Color(0xffFF8D08),
                                    size: 26,
                                  );
                                },
                                onTap: userLoggedIn ? (isLiked) async {
                                  this.isLiked = likeController.isPostLiked(widget.allData.announcementId!);
                                  _toggleLikeStatus(widget.allData.announcementId!);
                                  likeController.isPostLiked(widget.allData.announcementId!)
                                      ? ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      duration: Duration(
                                          milliseconds: 1000),
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.delete_outline,
                                            color: Colors.white,
                                          ),
                                          Text(
                                              "  Saqlanganlardan o'chirildi")
                                        ],
                                      ),
                                      backgroundColor:
                                      Color(0xffFF8D08),
                                    ),
                                  )
                                      : ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      duration: Duration(
                                          milliseconds: 1000),
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.white,
                                          ),
                                          Text(
                                              "  Saqlanglarga qo'shildi")
                                        ],
                                      ),
                                      backgroundColor:
                                      Colors.green,
                                    ),);

                                  return !isLiked;
                                } : (isLiked) async {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      duration: Duration(
                                          milliseconds: 1500),
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.heart_broken_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                              "Saqlanglarga qo'shish uchun avval\ntizimga kirishingiz kerak")
                                        ],
                                      ),
                                      backgroundColor:
                                      Color(0xffFF8D08),
                                    ),
                                  );
                                  return !isLiked;
                                },
                              ); }
                            ),
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
                    child: Text("${widget.allData.announcementPrice.toString()} ${widget.allData.announcementPriceType == 'dollar' ? '\$' : 'so\'m'}",
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
                        widget.allData.announcementTitle.toString(),
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
                        widget.allData.announcementDescription.toString(),
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
                child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: inChatMessageController.messageController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Xabar yozilmagan";
                    }
                    return null;
                  },
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
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          launch("tel:+${widget.allData.announcementPhone.toString()}");
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
                        child: FutureBuilder<bool>(
                          future: getLoginStatus(),
                          builder: (context, snapshot){
                            bool userLoggedIn = snapshot.data ?? false;
                            return ElevatedButton(
                              onPressed: userLoggedIn ? () {
                                if (
                                _formKey.currentState!
                                    .validate()) {
                                  inChatMessageController.inChatMessage( widget.allData.userId!,
                                      widget.allData.announcementId!);
                                }
                              } : (){
                                Get.snackbar(
                                  "Siz tizimga kirmagansiz",
                                  "Xabar yozish uchun iltimos tizimga kiring",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: const Color(0xFFFF8D08),
                                  forwardAnimationCurve: Curves.ease,
                                  colorText: Colors.white,
                                  margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                                  duration: const Duration(milliseconds: 2000),
                                  animationDuration: const Duration(milliseconds: 500),
                                );
                              },
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
                            );
                          },
                        )
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
                        backgroundImage: NetworkImage(ApiEndPoints.BASE_URL + widget.allData.announcementAvatar
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
                            widget.allData.announcementFullName.toString(),
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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:like_button/like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/controller/home_item_controller.dart';
import 'package:uy_joy_baraka/controller/like_controller.dart';
import 'package:uy_joy_baraka/controller/view_count_controller.dart';
import 'package:uy_joy_baraka/models/home_item.dart';
import 'package:uy_joy_baraka/screens/info.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';



class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  final imgList = [
    'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1475&q=80',
    'https://images.unsplash.com/photo-1616137466211-f939a420be84?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1332&q=80',
    'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1453&q=80',
  ];

  GetAllItemController getAllItemController = Get.put(GetAllItemController());
  ViewCounterController viewCounterController = Get.put(ViewCounterController());
  LikeController likeController = Get.put(LikeController());

  String? ijaravalue = "ijaraYokiSotuv";
  String? viloyat = "Toshkent";
  String? valyuta = "So'm";

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
    likeController.updateLikedPosts(likeController.allLikedPost);
  }

  // Function to perform unlike operation
  Future<void> _unlikePost(String postId) async {
    await likeController.unlike(postId);
    await likeController.fetchAndStoreLikedPosts();
    likeController.updateLikedPosts(likeController.allLikedPost);
  }



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
                        image: NetworkImage(imgL), fit: BoxFit.cover),
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
          // ALL ITEM
          Flexible(
              child:StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: getAllItemController.allItem.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Posts post = getAllItemController.allItem[index];
                  String postId = post.announcementId ?? '';
                  if ((index + 1) % 11 == 0) {
                    if (index < 11){
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        height: 260,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/ad_img.jpg",)
                          ),
                        ),
                        // AD BANNER
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
                      );
                    }else{
                      // SECOND AD BANNER
                      return Container(
                        height: 80,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xff008B51), width: 1)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(width: 5,),
                            Image.asset('assets/images/green3.png', width: 70,),
                            Container(
                              margin: const EdgeInsets.only(left: 35),
                              width: 140,
                              height: 90,
                              transform: Matrix4.skewX(-.3),
                              decoration: const BoxDecoration(
                                color: Color(0xff008B51),
                              ),
                              child: const Center(
                                child: SizedBox(
                                  width: 138,
                                  child: Text("Bizni ijtimoiy tarmoqlarda kuzating", textAlign: TextAlign.center,  style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),),
                                ),
                              ),
                            ),
                            Row(

                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF8D08),
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  height: 25,
                                  width: 25,
                                  child: Center(
                                    child: SvgPicture.asset('assets/icons/ri_facebook-fill.svg'),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFF8D08),
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  height: 25,
                                  width: 25,
                                  child: Center(
                                    child: SvgPicture.asset('assets/icons/mdi_instagram.svg'),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFFF8D08),
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  height: 25,
                                  width: 25,
                                  child: Center(
                                    child: SvgPicture.asset('assets/icons/mingcute_telegram-line.svg'),
                                  ),
                                ),
                                const SizedBox(width: 5,),
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  } else {
                    // CARD
                    return InkWell(
                      onTap: (){
                        viewCounterController.viewCounter(getAllItemController.allItem[index].announcementId);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoScreen(allData: getAllItemController.allItem[index]),),);
                      },
                      child: Container(
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
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                              ),
                              height: 200,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: ApiEndPoints.BASE_URL + getAllItemController
                                    .allItem[index].thumb![0],
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: Text(
                                        "${getAllItemController.allItem[index].city}",
                                        style: const TextStyle(
                                          color: Color(0xff666666),
                                          overflow: TextOverflow.ellipsis
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: IconButton(
                                      onPressed: () {
                                        _toggleLikeStatus(postId);
                                      },
                                      icon: Icon(
                                        likeController.isPostLiked(postId) ? Icons.favorite : Icons.favorite_border,
                                        color: likeController.isPostLiked(postId) ? Colors.red : null,
                                      ),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                            Padding(padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                              child: SizedBox(
                                height: 30,
                                child: Text('${getAllItemController.allItem[index].title}', style: const TextStyle(fontSize: 12),maxLines: 2,
                                  overflow: TextOverflow.ellipsis,),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                              child: SizedBox(
                                child: Row(
                                  children: [
                                    Text('${getAllItemController.allItem[index].price} ${getAllItemController.allItem[index].priceType! == 'dollar' ? '\$' : 'so\'m'}', style: const TextStyle(fontSize: 18, color: Color(0xff008B51)),maxLines: 1,
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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

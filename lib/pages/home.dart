// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/controller/advertising_controller.dart';
import 'package:uy_joy_baraka/controller/home_item_controller.dart';
import 'package:uy_joy_baraka/controller/like_controller.dart';
import 'package:uy_joy_baraka/controller/view_count_controller.dart';
import 'package:uy_joy_baraka/models/home_item.dart';
import 'package:uy_joy_baraka/screens/info.dart';
import 'package:uy_joy_baraka/screens/search.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  final imgList = [
    'assets/images/carusel_1.jpg',
    'assets/images/carusel_2.jpg',
    'assets/images/carusel_3.jpg',
  ];
  int randomNumber = 0;



  GetAllItemController getAllItemController = Get.put(GetAllItemController());
  ViewCounterController viewCounterController =
      Get.put(ViewCounterController());
  LikeController likeController = Get.put(LikeController());
  GetAdvertsDataController getAdvertsDataController =
      Get.put(GetAdvertsDataController());

  void generateRandomNumber() {
    Random random = Random();
    int newRandomNumber = random.nextInt(getAdvertsDataController.allAds.length); // 0 dan 99 gacha tasodifiy son olish
    setState(() {
      randomNumber = newRandomNumber;
    });
  }

  String? ijaravalue = "ijaraYokiSotuv";
  String? viloyat = "Toshkent";
  String? valyuta = "So'm";

  bool isLiked = false;

  Future<void> _toggleLikeStatus(String postId, var index) async {
    if (likeController.isPostLiked(postId)) {
      await _unlikePost(postId, index);
    } else {
      await _likePost(postId);
    }
  }

  // Function to perform like operation
  Future<void> _likePost(String postId) async {
    await likeController.like(postId);
    await likeController.fetchAndStoreLikedPosts();
    await likeController
        .getAllLikedPosts(); // Fetch the liked posts from the API
    likeController.updateLikedPosts(likeController.allLikedPost);
  }

  Future<void> _unlikePost(String postId, var index) async {
    await likeController.unlike(postId);
    await likeController.fetchAndStoreLikedPosts();
    await likeController
        .getAllLikedPosts(); // Fetch the liked posts from the API
    likeController.updateLikedPosts(likeController.allLikedPost);
    likeController
        .removeLikedPost(likeController.allLikedPost[index].announcementId!);
  }

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    likeController.initializeLikedPostIds();
    getAdvertsDataController.getAdvertsData();
    Timer.periodic(const Duration(seconds: 15), (Timer t) {
      generateRandomNumber();
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getAllItemController.loadNextPage();
    }
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    height: 43,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: const Color(0xff008B51), width: 2),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "search_ad".tr,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 43,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xff008B51),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // FILTER >>>>>>>

          // CAROUSEL >>>>>>>>
          Obx(() {
            if(getAdvertsDataController.loadItem.value) { return Stack(alignment: Alignment.center, children: [
              CarouselSlider.builder(
                options: CarouselOptions(
                    height: 250,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index)),
                itemCount: getAdvertsDataController.allAds.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  final add = getAdvertsDataController.allAds[index];
                  if (index == 0){
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(ApiEndPoints.BASE_URL + add.imgMob.toString()), fit: BoxFit.cover),
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
                                  SizedBox(
                                    width: 300,
                                    child: Text(
                                      "carousel_title".tr,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      launch(ApiEndPoints.authEndPoints.phone);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff008B51),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.phone_rounded,
                                          size: 20,
                                        ),
                                        Text(
                                          "button_title".tr,
                                          style: const TextStyle(fontSize: 14),
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
                  }else{
                    return GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(add.link.toString()));
                      },
                      child: CachedNetworkImage(
                        imageUrl: ApiEndPoints.BASE_URL + add.imgMob.toString(),
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover),
                              ),
                            ),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff008B51),
                            )),
                        errorWidget: (context, url, error) =>
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }
                },
              ),
              Positioned(
                  bottom: 10,
                  child: AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: getAdvertsDataController.allAds.length,
                    effect: const WormEffect(
                        dotWidth: 12,
                        dotHeight: 12,
                        activeDotColor: Color(0xffFF8D08),
                        dotColor: Colors.white),
                  ))
            ]); }else{ return carousel();}
          }),
          // TITLE
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: const Row(
              children: [
                Text("TOP",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff008B51))),
              ],
            ),
          ),
          // ALL ITEM
          Obx(() {
            if (getAllItemController.loadItem.value &&
                getAllItemController.page.value == 1) {
              return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return homeShimmer();
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1));
            } else {
              return Flexible(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: getAllItemController.allItem.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Posts post = getAllItemController.allItem[index];
                    String postId = post.announcementId ?? '';
                    if ((index + 1) % 11 == 0) {
                      if (index < 11) {
                        int ran =  randomNumber.toInt();
                        return GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(getAdvertsDataController.allAds[ran].link.toString()));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            height: 260,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    ApiEndPoints.BASE_URL +
                                        getAdvertsDataController.allAds[ran].imgMob
                                            .toString(),
                                  ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        // SECOND AD BANNER
                        return Container(
                          height: 80,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff008B51), width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                'assets/images/green3.png',
                                width: 70,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 35),
                                width: 140,
                                height: 90,
                                transform: Matrix4.skewX(-.3),
                                decoration: const BoxDecoration(
                                  color: Color(0xff008B51),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 138,
                                    child: Text(
                                      "social_title".tr,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse(ApiEndPoints.authEndPoints.youTube.toString()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFFF8D08),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      height: 25,
                                      width: 25,
                                      child: Center(
                                        child: SvgPicture.asset(
                                            'assets/icons/youtube.svg', width: 18,),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse(ApiEndPoints.authEndPoints.instagram.toString()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFFF8D08),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      height: 25,
                                      width: 25,
                                      child: Center(
                                        child: SvgPicture.asset(
                                            'assets/icons/mdi_instagram.svg'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(Uri.parse(ApiEndPoints.authEndPoints.telegram.toString()));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFFF8D08),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      height: 25,
                                      width: 25,
                                      child: Center(
                                        child: SvgPicture.asset(
                                            'assets/icons/mingcute_telegram-line.svg'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    } else {
                      // CARD
                      return InkWell(
                        onTap: () {
                          viewCounterController.viewCounter(getAllItemController
                              .allItem[index].announcementId);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InfoScreen(
                                  allData: getAllItemController.allItem[index]),
                            ),
                          );
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
                                offset: const Offset(
                                    0, 0), // changes position of shadow
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
                                  imageUrl: ApiEndPoints.BASE_URL +
                                      getAllItemController
                                          .allItem[index].thumb![0],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                    color: Color(0xff008B51),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        child: Text(
                                          "${getAllItemController.allItem[index].city}",
                                          style: const TextStyle(
                                              color: Color(0xff666666),
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 6),
                                      child: FutureBuilder<bool>(
                                          future: getLoginStatus(),
                                          builder: (context, snapshot) {
                                            bool userLoggedIn =
                                                snapshot.data ?? false;
                                            return LikeButton(
                                                size: 20,
                                                circleColor: const CircleColor(
                                                    start: Color(0xff00ddff),
                                                    end: Color(0xff0099cc)),
                                                bubblesColor:
                                                    const BubblesColor(
                                                  dotPrimaryColor:
                                                      Color(0xff33b5e5),
                                                  dotSecondaryColor:
                                                      Color(0xff0099cc),
                                                ),
                                                likeBuilder: (bool isLiked) {
                                                  return Icon(
                                                    likeController
                                                            .isPostLiked(postId)
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color:
                                                        const Color(0xffFF8D08),
                                                    size: 26,
                                                  );
                                                },
                                                onTap: userLoggedIn
                                                    ? (isLiked) async {
                                                        this.isLiked =
                                                            likeController
                                                                .isPostLiked(
                                                                    postId);
                                                        _toggleLikeStatus(
                                                            postId, index);
                                                        return !isLiked;
                                                      }
                                                    : (isLiked) async {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        1500),
                                                            content: Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .heart_broken_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                    "saved_alert"
                                                                        .tr)
                                                              ],
                                                            ),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xffFF8D08),
                                                          ),
                                                        );
                                                        return !isLiked;
                                                      });
                                          }),
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
                                    '${getAllItemController.allItem[index].title}',
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
                                  child: Row(
                                    children: [
                                      Text(
                                        '${getAllItemController.allItem[index].price} ${getAllItemController.allItem[index].priceType! == 'dollar' ? '\$' : 'so\'m'}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff008B51)),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                  staggeredTileBuilder: (int index) => (index + 1) % 11 == 0
                      ? const StaggeredTile.fit(2)
                      : const StaggeredTile.fit(1),
                ),
              );
            }
          }),
          getAllItemController.hasMoreData
              ? StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return homeShimmer();
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1))
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      "last_ads".tr,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  Widget carousel() => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
      ));

  Widget homeShimmer() => Container(
        margin: const EdgeInsets.all(10),
        height: 327,
        child: Column(
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 110,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox())
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox())
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Expanded(flex: 3, child: SizedBox())
              ],
            ),
          ],
        ),
      );
}

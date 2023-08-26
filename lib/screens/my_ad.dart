import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uy_joy_baraka/controller/active_inactive_patch_controller.dart';
import 'package:uy_joy_baraka/controller/delete_post_controller.dart';
import 'package:uy_joy_baraka/controller/get_active_post_controller.dart';
import 'package:uy_joy_baraka/screens/update_post.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({Key? key}) : super(key: key);

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  bool isLiked = false;
  bool value = false;

  List temp = [];

  GetActivePostController getActivePostController = GetActivePostController();
  GetInactivePostController getInactivePostController =
      GetInactivePostController();
  ActivePostController activePostController = ActivePostController();
  DeletePostController deletePostController = DeletePostController();

  @override
  void initState() {
    super.initState();
    getInactivePostController.getInactivePosts();
    getActivePostController.getActivePosts();
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
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.circular(5)),
                  child: TabBar(
                    physics: const ClampingScrollPhysics(),
                    // padding: EdgeInsets.all(10),
                    unselectedLabelColor: const Color(0xff008B51),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: const Color(0xff008B51),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onTap: (index) {
                      if (index == 0) {
                        getActivePostController.getActivePosts();
                      } else {
                        getInactivePostController.getInactivePosts();
                      }
                    },
                    tabs: const [
                      Tab(
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Faol"),
                          ),
                        ),
                      ),
                      Tab(
                        child: SizedBox(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Faol emas"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    Obx(() {
                      if (getActivePostController.loadItem.value) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 330, crossAxisCount: 2),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return homeShimmer();
                          },
                        );
                      } else {
                        if (getActivePostController.allActiveItem.isNotEmpty) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 330, crossAxisCount: 2),
                            itemCount:
                                getActivePostController.allActiveItem.length,
                            itemBuilder: (BuildContext context, int index) {
                              final active =
                                  getActivePostController.allActiveItem[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UpdatePostScreen(
                                        post: getActivePostController
                                            .allActiveItem[index],
                                      ),
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
                                        child: Stack(children: [
                                          CachedNetworkImage(
                                            imageUrl: ApiEndPoints.BASE_URL +
                                                getActivePostController
                                                    .allActiveItem[index]
                                                    .thumb![0],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8)),
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                              color: Color(0xff008B51),
                                            )),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          ),
                                          Transform.scale(
                                            scale: .6,
                                            alignment: Alignment.centerLeft,
                                            child: CupertinoSwitch(
                                                trackColor:
                                                    const Color(0xffFF8D08),
                                                thumbColor: !temp.contains(
                                                        active.announcementId!)
                                                    ? const Color(0xff008B51)
                                                    : Colors.white,
                                                activeColor: Colors.white,
                                                value: !temp.contains(
                                                    active.announcementId!),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    getActivePostController
                                                        .allActiveItem
                                                        .removeAt(index);
                                                    getInactivePostController
                                                        .allActiveItem
                                                        .add(active);
                                                    if (!temp.contains(active
                                                        .announcementId!)) {
                                                      temp.add(active
                                                          .announcementId!);
                                                      Get.snackbar(
                                                        "Muaffaqiyatli",
                                                        "E'lon nofaollashtirildi",
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        backgroundColor:
                                                            const Color(
                                                                0xFFFF8D08),
                                                        forwardAnimationCurve:
                                                            Curves.ease,
                                                        colorText: Colors.white,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            bottom: 10,
                                                            left: 10,
                                                            right: 10),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    2000),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                      );
                                                    }
                                                  });
                                                  activePostController
                                                      .activePost(active
                                                          .announcementId!);
                                                }),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 6),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: SizedBox(
                                                child: Text(
                                                  "${active.city}",
                                                  style: const TextStyle(
                                                      color: Color(0xff666666),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "${active.viewCount}",
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 6),
                                        child: SizedBox(
                                          child: Text(
                                            active.title!.toString(),
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                                '${active.price} ${active.priceType! == 'dollar' ? '\$' : 'so\'m'}',
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
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/lottie/empty.json',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Sizda faol e\'lonlar yo\'q',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    }),
                    Obx(() {
                      if (getInactivePostController.loadItem.value) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 330, crossAxisCount: 2),
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index) {
                            return homeShimmer();
                          },
                        );
                      } else {
                        if (getInactivePostController
                            .allActiveItem.isNotEmpty) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 350, crossAxisCount: 2),
                            itemCount:
                                getInactivePostController.allActiveItem.length,
                            itemBuilder: (BuildContext context, int index) {
                              final inactive = getInactivePostController
                                  .allActiveItem[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UpdatePostScreen(
                                        post: getInactivePostController
                                            .allActiveItem[index],
                                      ),
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
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: ApiEndPoints.BASE_URL +
                                                  getInactivePostController
                                                      .allActiveItem[index]
                                                      .thumb![0],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          topRight:
                                                              Radius.circular(
                                                                  8)),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                color: Color(0xff008B51),
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                    title: "E'lonni o'chirish",
                                                    content: const Text(
                                                        "E'lonni o'chirishni xohlaysizmi?"),
                                                    textCancel: "Yo'q",
                                                    textConfirm: "Ha",
                                                    confirmTextColor:
                                                        Colors.white,
                                                    cancelTextColor: Colors.red,
                                                    buttonColor: Colors.red,
                                                    onConfirm: () {
                                                      deletePostController
                                                          .deletePost(inactive
                                                              .announcementId!);
                                                      temp.remove(inactive
                                                          .announcementId!);
                                                      setState(() {
                                                        getInactivePostController
                                                            .allActiveItem
                                                            .removeAt(index);
                                                        Get.close(0);
                                                      });
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                              flex: 7,
                                              child: SizedBox(
                                                child: Text(
                                                  "${inactive.city}",
                                                  style: const TextStyle(
                                                      color: Color(0xff666666),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "${inactive.viewCount}",
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: SizedBox(
                                          child: Text(
                                            inactive.title!.toString(),
                                            style:
                                                const TextStyle(fontSize: 12),
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
                                                '${inactive.price} ${inactive.priceType! == 'dollar' ? '\$' : 'so\'m'}',
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
                                      inactive.confirm!
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4,
                                                  right: 4,
                                                  bottom: 6,
                                                  top: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    getInactivePostController
                                                        .allActiveItem
                                                        .removeAt(index);
                                                    getActivePostController
                                                        .allActiveItem
                                                        .add(inactive);
                                                    if (temp.contains(inactive
                                                        .announcementId!)) {
                                                      temp.remove(inactive
                                                          .announcementId!);
                                                      Get.snackbar(
                                                        "Muaffaqiyatli",
                                                        "E'lon faollashtirildi",
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        backgroundColor:
                                                            Colors.green,
                                                        forwardAnimationCurve:
                                                            Curves.ease,
                                                        colorText: Colors.white,
                                                        margin: const EdgeInsets
                                                                .only(
                                                            bottom: 10,
                                                            left: 10,
                                                            right: 10),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    2000),
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                      );
                                                    }
                                                  });
                                                  activePostController
                                                      .activePost(inactive
                                                          .announcementId!);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffFF8D08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: const Center(
                                                    child: Text(
                                                      "Faollashtirish",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const Text(
                                              "E'lon tasdiqlanishi\nkutilmoda",
                                              style:
                                                  TextStyle(color: Colors.red),
                                              textAlign: TextAlign.center,
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/lottie/empty.json',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Sizda nofaol e\'lonlar yo\'q',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

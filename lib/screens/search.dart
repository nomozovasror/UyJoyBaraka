import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/controller/search_controller.dart';
import 'package:uy_joy_baraka/controller/view_count_controller.dart';
import 'package:uy_joy_baraka/models/search_model.dart';
import 'package:uy_joy_baraka/screens/search_post_info.dart';

import '../controller/like_controller.dart';
import '../utils/api_endpoints.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GetSearchItemController getSearchItemController =
      Get.put(GetSearchItemController());
  LikeController likeController = Get.put(LikeController());
  ViewCounterController viewCounterController = Get.put(ViewCounterController());

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
  likeController.removeLikedPost(likeController.allLikedPost[index].announcementId!);
}

  String? ijaravalue = "";
  String? viloyat = "";
  String? valyuta = "";

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    likeController.initializeLikedPostIds();
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
      getSearchItemController.loadNextPage();
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
    return Center(
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            getSearchItemController.hasMoreData.value = true;
            ijaravalue = "";
            viloyat = "";
            valyuta = "";
            getSearchItemController.allSearchedPost.clear();
            getSearchItemController.page.value = 1;
            getSearchItemController.startSearch.value = false;
            getSearchItemController.searchController.clear();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
                onTap: () {
                  getSearchItemController.hasMoreData.value = true;
                  ijaravalue = "";
                  viloyat = "";
                  valyuta = "";
                  getSearchItemController.allSearchedPost.clear();
                  getSearchItemController.page.value = 1;
                  getSearchItemController.startSearch.value = false;
                  getSearchItemController.searchController.clear();
                  Navigator.pop(context);
                },
              ),
              title: Image.asset('assets/images/logo.png', height: 40),
              backgroundColor: const Color(0xff008B51),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                  controlAffinity: ListTileControlAffinity.leading,
                  leading: Container(
                    height: 40,
                    width: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xff008B51),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/filter-alt.svg",
                        height: 24,
                        width: 24,
                        color: const Color(0xff008B51),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: getSearchItemController.searchController,
                          decoration: InputDecoration(
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xff008B51), width: 2),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Color(0xff008B51), width: 2),
                            ),
                            hintText: "Qidirish",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 43,
                          child: ElevatedButton(
                            onPressed: () {
                              getSearchItemController.hasMoreData.value = true;
                              getSearchItemController.allSearchedPost.clear();
                              getSearchItemController.page.value = 1;
                              setState(() {
                                getSearchItemController.startSearch.value = true;
                              });
                              getSearchItemController.getSearchItem(
                                  valyuta.toString(),
                                  viloyat.toString(),
                                  ijaravalue.toString(),
                              );},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff008B51),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  children: [
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
                                border: Border.all(
                                    color: const Color(0xff008B51), width: 1.5),
                                borderRadius: BorderRadius.circular(6)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: ijaravalue,
                                  hint: const Text("Sotuv"),
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
                                      value: "",
                                      child: Text(
                                        'Sotuv yoki ijara',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
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
                                      this.ijaravalue = ijaravalue;
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
                                border: Border.all(
                                    color: const Color(0xff008B51), width: 1.5),
                                borderRadius: BorderRadius.circular(6)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: viloyat,
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
                                      value: "",
                                      child: Text(
                                        'Viloyat',
                                        style: TextStyle(color: Colors.grey),
                                        softWrap: true,
                                      ),
                                    ),
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
                                      value: "Fargona",
                                      child: Text(
                                        'fargona',
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
                                      value: "Qoraqalpogiston",
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
                                  onChanged: (viloyat) {
                                    setState(() {
                                      this.viloyat = viloyat;
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
                                border: Border.all(
                                    color: const Color(0xff008B51), width: 1.5),
                                borderRadius: BorderRadius.circular(6)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: valyuta,
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
                                      value: "",
                                      child: Text(
                                        'valyuta',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
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
                                      this.valyuta = valyuta;
                                    });
                                  }),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                ijaravalue = "";
                                viloyat = "";
                                valyuta = "";
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xff008B51),
                                    borderRadius: BorderRadius.circular(6)),
                                margin: const EdgeInsets.only(
                                    top: 12, bottom: 6, right: 10),
                                width: 50,
                                child: const Icon(
                                  Icons.restart_alt_outlined,
                                  color: Colors.white,
                                )),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (getSearchItemController.loadItem.value &&
                      getSearchItemController.page.value == 1) {
                    return StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return homeShimmer();
                        }, staggeredTileBuilder: (int index) =>
                    const StaggeredTile.fit(1)
                    );
                  } else {
                    return Flexible(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 2,
                        itemCount: getSearchItemController.allSearchedPost.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          SearchPosts post = getSearchItemController.allSearchedPost[index];
                          String postId = post.announcementId ?? '';
                            // CARD
                            return InkWell(
                              onTap: () {
                                viewCounterController.viewCounter(getSearchItemController
                                    .allSearchedPost[index].announcementId);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SearchInfoScreen(
                                        allData: getSearchItemController.allSearchedPost[index]),
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
                                            getSearchItemController
                                                .allSearchedPost[index].thumb![0],
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
                                                "${getSearchItemController.allSearchedPost[index].city}",
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
                                                    likeController.isPostLiked(postId) ? Icons.favorite : Icons.favorite_border,
                                                    color: const Color(0xffFF8D08),
                                                    size: 26,
                                                  );
                                                },
                                                onTap: userLoggedIn ? (isLiked) async {
                                                  this.isLiked = likeController.isPostLiked(postId);
                                                  _toggleLikeStatus(postId, index);
                                                  likeController.isPostLiked(postId)
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
                                              ); },
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
                                          '${getSearchItemController.allSearchedPost[index].title}',
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
                                              '${getSearchItemController.allSearchedPost[index].price} ${getSearchItemController.allSearchedPost[index].priceType! == 'dollar' ? '\$' : 'so\'m'}',
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
                        staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                      ),
                    );
                  }
                }),
                Obx((){
                  if (getSearchItemController.startSearch.value){
                    if (getSearchItemController.hasMoreData.value){
                      return StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return homeShimmer();
                          }, staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1)
                      );}else{
                      if (getSearchItemController.allSearchedPost.isEmpty){
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 100,),
                              Lottie.asset("assets/lottie/search.json",
                                  height: 200, width: 200),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Sizning so'rovingiz bo'yicha hech narsa topilmadi",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }else{
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: Text(
                              "Oxiriga yettingiz",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }
                    }
                  }else{
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 100,),
                          Lottie.asset("assets/lottie/start_search.json",
                              height: 200, width: 200),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Izlash uchun kalit so'zni kiriting",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    );
                  }
                })
              ]),
            ),
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
            const Expanded(
                flex: 1,
                child: SizedBox())
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
            const Expanded(
                flex: 2,
                child: SizedBox())
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
            const Expanded(
                flex: 3,
                child: SizedBox())
          ],
        ),
      ],
    ),
  );
}

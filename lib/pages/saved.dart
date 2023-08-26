import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controller/like_controller.dart';
import '../models/liked_posts.dart';
import '../screens/liked_post_info.dart';
import '../utils/api_endpoints.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  LikeController likeController = Get.put(LikeController());

  @override
  void initState() {
    super.initState();
    likeController.initializeLikedPostIds();
  }

  var likedCheck = true.obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Obx(() {
              return likeController.likedPosts.isNotEmpty
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: likeController.allLikedPost.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        LikeModel post = likeController.allLikedPost[index];
                        // CARD
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LikedInfoScreen(
                                    allData:
                                        likeController.allLikedPost[index]),
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
                                        likeController.allLikedPost[index]
                                            .announcementThumb![0],
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
                                      ),
                                    ),
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
                                            "${likeController.allLikedPost[index].announcementCity}",
                                            style: const TextStyle(
                                                color: Color(0xff666666),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        onPressed: () async {
                                          await likeController
                                              .unlike(post.announcementId!);
                                          likeController.removeLikedPost(
                                              post.announcementId!);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Color(0xffFF8D08),
                                          size: 26,
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
                                      '${likeController.allLikedPost[index].announcementTitle}',
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
                                          '${likeController.allLikedPost[index].announcementPrice} ${likeController.allLikedPost[index].announcementPriceType! == 'dollar' ? '\$' : 'so\'m'}',
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
                      staggeredTileBuilder: (int index) =>
                          const StaggeredTile.fit(1),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/lottie/favorite.json',
                              height: 200,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Sizda saqlangan e\'lonlar yo\'q',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Siz saqlangan e\'lonlarni shu yerda ko\'rishingiz mumkin',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    );
            }),
          ),
        ],
      ),
    );
  }
}

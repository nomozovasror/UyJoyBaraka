import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uy_joy_baraka/controller/get_active_post_controller.dart';
import 'package:uy_joy_baraka/models/models.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({Key? key}) : super(key: key);

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  bool isLiked = false;
  bool value = false;

  GetActivePostController getActivePostController = GetActivePostController();

  @override
  void initState() {
    super.initState();
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
                      Obx((){
                        if (getActivePostController.loadItem.value){
                          return  GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 330, crossAxisCount: 2),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return homeShimmer();
                            },
                          );
                        }else{
                          return GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 330, crossAxisCount: 2),
                            itemCount: getActivePostController.allActiveItem.length,
                            itemBuilder: (BuildContext context, int index) {
                              final active = getActivePostController.allActiveItem[index];
                              return Container(
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
                                          children: [ CachedNetworkImage(
                                            imageUrl: ApiEndPoints.BASE_URL +
                                                getActivePostController
                                                    .allActiveItem[index].thumb![0],
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
                                          ),Transform.scale(
                                            scale: .6,
                                            alignment: Alignment.centerLeft,
                                            child: CupertinoSwitch(
                                              trackColor: const Color(0xffFF8D08),
                                              thumbColor: value
                                                  ? const Color(0xff008B51)
                                                  : Colors.white,
                                              activeColor: Colors.white,
                                              value: value,
                                              onChanged: (value) => setState(
                                                      () => this.value = value),
                                            ),
                                          ),]
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
                                                "${active.city}",
                                                style: const TextStyle(
                                                    color: Color(0xff666666),
                                                    overflow: TextOverflow.ellipsis),
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
                                        child: Text(
                                          active.title!.toString(),
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
                              );
                            },
                          );
                        }
                      }),
                      GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 365, crossAxisCount: 2),
                        itemCount: houses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final house = houses[index];
                          return Container(
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
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(house.img[0]),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8)),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Toshkent",
                                        style: TextStyle(
                                          color: Color(0xff666666),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 6),
                                  child: SizedBox(
                                    child: Text(
                                      'Olmazor tumanida joylashgan 2x kvartira ijaraga beriladi',
                                      style: TextStyle(fontSize: 12),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  child: SizedBox(
                                    child: Text(
                                      '2 250 000 so’m',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff008B51)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4, right: 4, bottom: 6, top: 2),
                                  child: InkWell(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffFF8D08),
                                          borderRadius:
                                          BorderRadius.circular(4)),
                                      child: const Center(
                                          child: Text(
                                            "Faollashtirish",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
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
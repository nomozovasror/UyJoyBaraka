import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:uy_joy_baraka/models.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({Key? key}) : super(key: key);

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  bool isLiked = false;
  bool value = false;

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
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 350, crossAxisCount: 2),
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
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Transform.scale(
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
                                            isTapped ? 'assets/icons/fill_like.svg' : 'assets/icons/mdi_heart-outline.svg',
                                            color:const Color(0xffFF8D08),
                                          );
                                        },
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
                                      horizontal: 4, vertical: 6),
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
                              ],
                            ),
                          );
                        },
                      ),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            isTapped ? 'assets/icons/fill_like.svg' : 'assets/icons/mdi_heart-outline.svg',
                                            color: const Color(0xffFF8D08),
                                          );
                                        },
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
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/models.dart';

class AdScreen extends StatefulWidget {
  const AdScreen({Key? key}) : super(key: key);

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  @override
  Widget build(BuildContext context) {
    int counter = 0;

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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                    children: [StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: houses.length,
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final house = houses[index];
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
                              var isLiked = true;
                              return InkWell(
                                onTap: (){
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
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(house.img[0]),
                                              fit: BoxFit.cover),
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8)),
                                        ),
                                        height: 200,
                                        width: double.infinity,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 6),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Toshkent",
                                              style: TextStyle(
                                                color: Color(0xff666666),
                                              ),
                                            ),
                                            LikeButton(
                                              size: 24,
                                              isLiked: isLiked = true,
                                              likeBuilder: (isTapped) {
                                                return SvgPicture.asset(
                                                  'assets/icons/mdi_heart-outline.svg',
                                                  color: isTapped
                                                      ? Colors.red
                                                      : const Color(0xffFF8D08),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(padding:  EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 6),
                                        child: SizedBox(
                                          child: Text('Olmazor tumanida joylashgan 2x kvartira ijaraga beriladi', style: TextStyle(fontSize: 12),maxLines: 2,
                                            overflow: TextOverflow.ellipsis,),
                                        ),
                                      ),
                                      const Padding(padding:  EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 6),
                                        child: SizedBox(
                                          child: Text('2 250 000 so’m', style: TextStyle(fontSize: 18, color: Color(0xff008B51)),maxLines: 1,
                                            overflow: TextOverflow.ellipsis,),
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
                      
                      Center(
                        child: Text("2"),
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

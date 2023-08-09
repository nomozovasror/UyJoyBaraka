// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/auth/edit_user_data.dart';
import 'package:uy_joy_baraka/controller/user_data_controller.dart';
import 'package:uy_joy_baraka/screens/about.dart';
import 'package:uy_joy_baraka/screens/my_ad.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  @override
  void initState() {
    super.initState();
    getUserDataController
        .getUserData(); // Call fetchUserData to initiate data fetching
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GetBuilder<GetUserDataController>(builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: controller.user.avatar != ''
                      ? Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                ApiEndPoints.BASE_URL + controller.user.avatar!,
                              ),
                              radius: 30,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.user.fullName.toString(),
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff181725),
                                          letterSpacing: .8),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditUserDataScreen()),
                                        );
                                      },
                                      child: const SizedBox(
                                          width: 40,
                                          height: 25,
                                          child: Icon(
                                            Icons.edit_outlined,
                                            color: Color(0xFF53B175),
                                            size: 22,
                                          )),
                                    ),
                                  ],
                                ),
                                Text(
                                  "+${controller.user.phone.toString()}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff7C7C7C),
                                      letterSpacing: .8),
                                ),
                              ],
                            )
                          ],
                        )
                      : userShimmer(),
                ),
                const Divider(
                  thickness: 1.6,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/Orders.svg"),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text("E’lonlarim",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff181725)))
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AdScreen()),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.6,
                ),
                InkWell(
                  onTap: () {
                    launch("https://t.me/D34th5hot");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/help.svg"),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text("Yordam",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff181725)))
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              launch("https://t.me/D34th5hot");
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.6,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/about.svg"),
                            const SizedBox(
                              width: 12,
                            ),
                            const Text("Sayt haqida ma'lumot",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff181725)))
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AboutScreen()),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.6,
                ),
              ],
            );
          }),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                color: const Color(0xffF2F3F2),
                borderRadius: BorderRadius.circular(18)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/icons/exit.svg"),
                const Text(
                  "Chiqish",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff53B175)),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget userShimmer() => Row(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 26,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 14,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}

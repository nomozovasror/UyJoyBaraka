// ignore_for_file: deprecated_member_use
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uy_joy_baraka/auth/edit_user_data.dart';
import 'package:uy_joy_baraka/auth/login.dart';
import 'package:uy_joy_baraka/controller/user_data_controller.dart';
import 'package:uy_joy_baraka/screens/about.dart';
import 'package:uy_joy_baraka/screens/my_ad.dart';
import 'package:uy_joy_baraka/utils/api_endpoints.dart';
import 'package:uy_joy_baraka/utils/localization_controller.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  LocalizationController localizationController =
      Get.put(LocalizationController());

  @override
  void initState() {
    super.initState();
    getUserDataController.getUserData();
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
    return FutureBuilder<bool>(
        future: getLoginStatus(),
        builder: (context, snapshot) {
          bool userLoggedIn = snapshot.data ?? false;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GetBuilder<GetUserDataController>(builder: (controller) {
                  return Column(
                    children: [
                      userLoggedIn
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: controller.user.avatar != ''
                                  ? Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: ApiEndPoints.BASE_URL +
                                              controller.user.avatar.toString(),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 65,
                                            height: 65,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
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
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 220),
                                                  child: Text(
                                                    controller.user.fullName
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xff181725),
                                                      letterSpacing: .8,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
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
                                                        color:
                                                            Color(0xFF53B175),
                                                        size: 24,
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
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
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF008B51),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AuthScreen()),
                                    );
                                  },
                                  child: Text(
                                    "login".tr,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                      userLoggedIn
                          ? const Divider(
                              thickness: 1.6,
                            )
                          : Container(),
                      userLoggedIn
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AdScreen()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/Orders.svg"),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text("adds".tr,
                                            style: const TextStyle(
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
                                                builder: (context) =>
                                                    const AdScreen()),
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded))
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      const Divider(
                        thickness: 1.6,
                      ),
                      InkWell(
                        onTap: () {
                          launch(ApiEndPoints.authEndPoints.telegramBotUrl);
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
                                  Text("help".tr,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff181725)))
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    launch(ApiEndPoints
                                        .authEndPoints.telegramBotUrl);
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded))
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
                                  Text("about".tr,
                                      style: const TextStyle(
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
                                          builder: (context) =>
                                              const AboutScreen()),
                                    );
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded)),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1.6,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(context: context, builder: (BuildContext context){
                            return SimpleDialog(
                              contentPadding: const EdgeInsets.all(10),
                              children: [
                                InkWell(
                                  onTap: () async {
                                    localizationController.selectedLanguage = 'uz';
                                    Get.updateLocale(const Locale('uz'));
                                    Get.back();
                                  },
                                  child: const Row(
                                    children: [
                                      Text('🇺🇿', style: TextStyle(fontSize: 22),),
                                      SizedBox(width: 10,),
                                      Text("O'zbekcha", style: TextStyle(fontSize: 20),)
                                    ],
                                  )
                                ),
                                const Divider(
                                  thickness: 1.6,
                                ),
                                InkWell(
                                    onTap: () async {
                                      localizationController.selectedLanguage = 'ru';
                                      Get.updateLocale(const Locale('ru'));
                                      Get.back();
                                    },
                                    child: const Row(
                                      children: [
                                        Text('🇷🇺', style: TextStyle(fontSize: 22),),
                                        SizedBox(width: 10,),
                                        Text("Русский", style: TextStyle(fontSize: 20),)
                                      ],
                                    )
                                ),
                                const Divider(
                                  thickness: 1.6,
                                ),
                                InkWell(
                                    onTap: () async {
                                      localizationController.selectedLanguage = 'en';
                                      Get.updateLocale(const Locale('en'));
                                      Get.back();
                                    },
                                    child: const Row(
                                      children: [
                                        Text('🇬🇧', style: TextStyle(fontSize: 22),),
                                        SizedBox(width: 10,),
                                        Text("English", style: TextStyle(fontSize: 20),)
                                      ],
                                    )
                                ),
                              ],
                            );
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.language),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text("change_language".tr,
                                      style: const TextStyle(
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
                                          builder: (context) =>
                                          const AboutScreen()),
                                    );
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded)),
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
                userLoggedIn
                    ? GestureDetector(
                        onTap: () {
                          if (Platform.isAndroid) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("logout_alert".tr),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("no".tr),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final SharedPreferences prefs =
                                          await _prefs;
                                      prefs.clear();
                                      prefs.setBool('isLoggedIn', false);
                                      await likeController.deleteAllLikedData();
                                      getUserDataController.deleteUserData();
                                      Get.offAll(() => const MyHomePage());
                                    },
                                    child: Text("yes".tr),
                                  )
                                ],
                              ),
                            );
                          } else {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text("reset_password_question".tr),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("no".tr),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      final SharedPreferences prefs =
                                          await _prefs;
                                      prefs.clear();
                                      prefs.setBool('isLoggedIn', false);
                                      await likeController.deleteAllLikedData();
                                      getUserDataController.deleteUserData();
                                      Get.offAll(() => const MyHomePage());
                                    },
                                    child: Text("yes".tr),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                              color: const Color(0xffF2F3F2),
                              borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset("assets/icons/exit.svg"),
                              Text(
                                "logout".tr,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff53B175)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        });
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

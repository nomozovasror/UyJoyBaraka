// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uy_joy_baraka/controller/like_controller.dart';
import 'package:uy_joy_baraka/pages/ad.dart';
import 'package:uy_joy_baraka/pages/chat.dart';
import 'package:uy_joy_baraka/pages/home.dart';
import 'package:uy_joy_baraka/pages/profile.dart';
import 'package:uy_joy_baraka/pages/saved.dart';
import 'package:uy_joy_baraka/screens/start_screen.dart';
import 'package:uy_joy_baraka/utils/locale_string.dart';
import 'package:uy_joy_baraka/utils/localization_controller.dart';

Future<void> initSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('isLoggedIn')) {
    prefs.setBool('isLoggedIn', false);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPreferences();
  LikeController likeController = Get.put(LikeController());
  await likeController.fetchAndStoreLikedPosts();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final isFirst = prefs.getBool('isFirst') ?? false;
  await GetStorage.init();
  final localizationController = Get.put(LocalizationController());
  localizationController.initSelectedLanguage();
  runApp(MyApp(
    isFirst: isFirst,
  ));
}

class MyApp extends StatefulWidget {
  final bool isFirst;

  const MyApp({Key? key, required this.isFirst}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? selectedLanguage;

  _loadSelectedLanguage() {
    final localizationController = Get.find<LocalizationController>();
    setState(() {
      selectedLanguage = localizationController.selectedLanguage;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocaleString(),
      locale: Locale(selectedLanguage ?? 'uz'),
      debugShowCheckedModeBanner: false,
      title: 'Uy Joy Baraka',
      home: widget.isFirst ? const MyHomePage() : const StartScreen(),
    );
  }
}


LikeController likeController = Get.put(LikeController());

Future<void> updatePost() async {
  likeController.updateLikedPosts(likeController.allLikedPost);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  List pagesList = const [
    HomeScreen(),
    SavedScreen(),
    AddAdScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/images/logo.png', height: 40),
            backgroundColor: const Color(0xff008B51),
            centerTitle: true,
          ),
          body: pagesList[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xffFF8D08),
            unselectedItemColor: const Color(0xff130F26),
            selectedFontSize: 10,
            unselectedFontSize: 10,
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 1) {
                updatePost();
              }
              setState(() {
                currentIndex = index;
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/tabler_category.svg',
                  color: currentIndex == 0
                      ? const Color(0xffFF8D08)
                      : const Color(0xff130F26),
                  width: 28,
                  height: 28,
                ),
                label: "menu_title".tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/mdi_heart-outline.svg',
                  color: currentIndex == 1
                      ? const Color(0xffFF8D08)
                      : const Color(0xff130F26),
                  width: 28,
                  height: 28,
                ),
                label: "saved_title".tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/mdi_plus-outline.svg',
                  color: currentIndex == 2
                      ? const Color(0xffFF8D08)
                      : const Color(0xff130F26),
                  width: 28,
                  height: 28,
                ),
                label: "add_title".tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/majesticons_chat-line.svg',
                  color: currentIndex == 3
                      ? const Color(0xffFF8D08)
                      : const Color(0xff130F26),
                  width: 28,
                  height: 28,
                ),
                label: "chat_title".tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/solar_user-outline.svg',
                  color: currentIndex == 4
                      ? const Color(0xffFF8D08)
                      : const Color(0xff130F26),
                  width: 28,
                  height: 28,
                ),
                label: "profile_title".tr,
              ),
            ],
          )),
    );
  }
}

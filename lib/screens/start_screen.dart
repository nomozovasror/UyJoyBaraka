import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

int currentIndex = 0;

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        currentIndex = 1;
      });
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/start_image.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Color(0xDD008B51)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  AnimatedAlign(
                    curve: Curves.easeInOut,
                    alignment: currentIndex == 0
                        ? const Alignment(7, 0)
                        : Alignment.center,
                    duration: const Duration(milliseconds: 500),
                    child: const Text(
                      "Xush kelibsiz\nUy joy baraka",
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AnimatedOpacity(
                    opacity: currentIndex == 0 ? 0 : 1,
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      "O’zingizga kerakli uyni tez va oson toping",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  AnimatedContainer(
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 500),
                    width: currentIndex == 0
                        ? 0
                        : MediaQuery.of(context).size.width * 0.8,
                    height: currentIndex == 0 ? 0 : 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF008B51),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: currentIndex == 0
                        ? const Text('')
                        : InkWell(
                            onTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              prefs.setBool('isFirst', true);
                              Get.offAll(const MyHomePage());
                            },
                            child: const Center(
                              child: Text(
                                "Boshlash",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

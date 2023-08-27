import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

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
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Biz haqimizda",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff008B51),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Uy joy baraka - Bu O'zbekistonda onlayn uy joylarni, sotish va ijaraga olish uchun platforma. Toshkent, Samarqand, Andijon yoki boshqa shaharlarda kvartira, uy yoki ofis sotib olish yoki sotishni istaysizmi? Siz to'g'ri manzildasiz! Bu yerda O'zbekistonning ko'plab potentsial sotuvchilarni ko'rish mumkin. Biz sizga xohlagan uy joylarni oson topishingizga yoki uyi joylaringizni  muvaffaqiyatli sotishingizda yordam bera olishimiz mumkin.",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 80,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xff008B51), width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          'assets/images/green3.png',
                          width: 70,
                        ),
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
                              child: Text(
                                "Bizni ijtimoiy tarmoqlarda kuzating",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFF8D08),
                                  borderRadius: BorderRadius.circular(50)),
                              height: 25,
                              width: 25,
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/icons/ri_facebook-fill.svg'),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFF8D08),
                                  borderRadius: BorderRadius.circular(50)),
                              height: 25,
                              width: 25,
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/icons/mdi_instagram.svg'),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFF8D08),
                                  borderRadius: BorderRadius.circular(50)),
                              height: 25,
                              width: 25,
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/icons/mingcute_telegram-line.svg'),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Biz mijozlarimizni qadrlaymiz. Bizning adminlarimiz joylashtirilgan e'lonlar haqida savollaringizga javob berishadi. Biz o'zimizni qidiruvni qulaylashtiradigan tanlov kriteriyalarini taqdim etamiz, shunda siz qidirayotgan narsani va qidirayotgan joyda topishingiz mumkin. Siz telefon orqali yoki e'lon joylashtirgan sotuvchi bilan to'g'ridan-to'g'ri bog'lanishingiz mumkin. Biz sizning xohishlarizni topishning tez, tashkil etilgan va samarali usulini taqdim etishga harakat qilamiz. \n\nBizning platformada e'lon joylashtirish tezkor va qulay. Siz bir necha daqiqada e'lon joylashtirishingiz mumkin, uy haqida ma'lumotlarini taqdim qilishingiz, tasvirlarni qo'shishingiz va potentsial sotuvchilar uchun qulayliklarni ko'rsatishingiz mumkin. Siz o'z profilni boshqarishingiz va O'zbekistondagi ko'plab potentsial sotuvchilarga kirishiga ega bo'lishingiz mumkin. Nima uchun kutmoqdasiz? Qo'shiling!\n\nHurmat bilan,\nUy joy baraka jamoasi",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

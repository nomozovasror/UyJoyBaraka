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
                          "Друзья, наш сайт был специально создан для розничной и оптовой продажи интерьерного освещения на территории России. Мы сотрудничаем с ведущими производителями светотехнического оборудования, которые зарекомендовали себя на мировом рынке. Поэтому не стоит сомневаться в надёжном качестве продукции, представленной на страницах сайта. Интернет-магазин - это полноценный online-shop. Мы работаем без выходных, 24 часа в сутки и непрерывно расширяем и обновляем ассортимент товаров, чтобы каждый покупатель мог подобрать светотехнику, соответствующую его нуждам и желаниям. Наш магазин работает с большим количеством производителей, что позволяет найти светильник на самый утонченный . ",
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
                  ),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Интернет-магазин «Ваша Лампа» - это полноценный online-shop. Мы работаем без выходных, 24 часа в сутки и непрерывно расширяем и обновляем ассортимент товаров, чтобы каждый покупатель мог подобрать светотехнику, соответствующую его нуждам и желаниям. Друзья, наш сайт был специально создан для розничной и оптовой продажи интерьерного освещения на территории России. Мы сотрудничаем с ведущими производителями светотехнического оборудования, которые зарекомендовали себя на мировом рынке. Поэтому не стоит сомневаться в надёжном качестве продукции, представленной на страницах сайта. Интернет-магазин  это полноценный online-shop. Мы работаем без выходных, 24 часа в сутки и непрерывно расширяем и обновляем ассортимент товаров, чтобы каждый покупатель мог подобрать светотехнику, соответствующую его нуждам и желаниям",
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
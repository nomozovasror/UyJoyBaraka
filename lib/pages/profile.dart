import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uy_joy_baraka/screens/about.dart';
import 'package:uy_joy_baraka/screens/my_ad.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/user.jpg"),
                      radius: 30,
                    ),
                    SizedBox(width: 16,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "N. Mironshoh",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff181725),
                            letterSpacing: .8
                          ),
                        ),
                        Text(
                          "id:658997788",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7C7C7C),
                            letterSpacing: .8
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(thickness: 1.6,),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      SvgPicture.asset("assets/icons/Orders.svg"),
                      const SizedBox(width: 12,),
                      const Text(
                          "E’lonlarim",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff181725)
                          )
                      )
                    ],),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ),
              const Divider(thickness: 1.6,),
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
                      Row(children: [
                        SvgPicture.asset("assets/icons/help.svg"),
                        const SizedBox(width: 12,),
                        const Text(
                            "Yordam",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff181725)
                            )
                        )
                      ],),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_rounded))
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 1.6,),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SvgPicture.asset("assets/icons/about.svg"),
                        const SizedBox(width: 12,),
                        const Text(
                            "Sayt haqida ma'lumot",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff181725)
                            )
                        )
                      ],),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_rounded))
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 1.6,),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF2F3F2),
              borderRadius: BorderRadius.circular(18)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("assets/icons/exit.svg"),
                const Text(
                    "Chiqish",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff53B175)
                    ),
                ),
                const SizedBox(width: 5,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

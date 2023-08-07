import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uy_joy_baraka/controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  GetSearchItemController getSearchItemController =
      Get.put(GetSearchItemController());

  String? ijaravalue = "";
  String? viloyat = "";
  String? valyuta = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/images/logo.png', height: 40),
            backgroundColor: const Color(0xff008B51),
            centerTitle: true,
          ),
          body: Column(mainAxisSize: MainAxisSize.min, children: [
            ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 10),
              controlAffinity: ListTileControlAffinity.leading,
              leading: Container(
                height: 40,
                width: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xff008B51),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/filter-alt.svg",
                    height: 24,
                    width: 24,
                    color: const Color(0xff008B51),
                  ),
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      controller: getSearchItemController.searchController,
                      decoration: InputDecoration(
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff008B51), width: 2),
                        ),
                        contentPadding: const EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: Color(0xff008B51), width: 2),
                        ),
                        hintText: "Qidirish",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 43,
                      child: ElevatedButton(
                        onPressed: () {
                          getSearchItemController.getSearchItem(
                              valyuta.toString(),
                              viloyat.toString(),
                              ijaravalue.toString());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff008B51),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              children: [
                SizedBox(
                  height: 56,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 6, top: 12, left: 8, right: 4),
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff008B51), width: 1.5),
                            borderRadius: BorderRadius.circular(6)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: ijaravalue,
                              hint: const Text("Sotuv"),
                              borderRadius: BorderRadius.circular(6),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              iconSize: 24,
                              style: const TextStyle(
                                  color: Color(0xff272727),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              items: const [
                                DropdownMenuItem(
                                  value: "",
                                  child: Text(
                                    'Sotuv yoki ijara',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "sale",
                                  child: Text(
                                    'Sotuv',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "rent",
                                  child: Text(
                                    'Ijara',
                                  ),
                                ),
                              ],
                              onChanged: (ijaravalue) {
                                setState(() {
                                  this.ijaravalue = ijaravalue;
                                });
                              }),
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(
                            bottom: 6, top: 12, left: 4, right: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff008B51), width: 1.5),
                            borderRadius: BorderRadius.circular(6)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: viloyat,
                              borderRadius: BorderRadius.circular(6),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              iconSize: 24,
                              style: const TextStyle(
                                  color: Color(0xff272727),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              items: const [
                                DropdownMenuItem(
                                  value: "",
                                  child: Text(
                                    'Viloyat',
                                    style: TextStyle(color: Colors.grey),
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Toshkent",
                                  child: Text(
                                    'Toshkent',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Andijon",
                                  child: Text(
                                    'Andijon',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Buxoro",
                                  child: Text(
                                    'Buxoro',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Fargona",
                                  child: Text(
                                    'fargona',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Xorazm",
                                  child: Text(
                                    'Xorazm',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Namangan",
                                  child: Text(
                                    'Namangan',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Navoiy",
                                  child: Text(
                                    'Navoiy',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Qashqadaryo",
                                  child: Text(
                                    'Qashqadaryo',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Qoraqalpogiston",
                                  child: Text(
                                    'Qoraqalpogʻiston',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Samarqand",
                                  child: Text(
                                    'Samarqand',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Sirdaryo",
                                  child: Text(
                                    'Sirdaryo',
                                    softWrap: true,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "Surxondaryo",
                                  child: Text(
                                    'Surxondaryo',
                                    softWrap: true,
                                  ),
                                ),
                              ],
                              onChanged: (viloyat) {
                                setState(() {
                                  this.viloyat = viloyat;
                                });
                              }),
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(
                            bottom: 6, top: 12, left: 4, right: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff008B51), width: 1.5),
                            borderRadius: BorderRadius.circular(6)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: valyuta,
                              borderRadius: BorderRadius.circular(6),
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              iconSize: 24,
                              style: const TextStyle(
                                  color: Color(0xff272727),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                              items: const [
                                DropdownMenuItem(
                                  value: "",
                                  child: Text(
                                    'valyuta',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "sum",
                                  child: Text(
                                    "so'm",
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: "dollar",
                                  child: Text(
                                    'dollar',
                                  ),
                                ),
                              ],
                              onChanged: (valyuta) {
                                setState(() {
                                  this.valyuta = valyuta;
                                });
                              }),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ijaravalue = "";
                            viloyat = "";
                            valyuta = "";
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff008B51),
                                borderRadius: BorderRadius.circular(6)),
                            margin: const EdgeInsets.only(
                                top: 12, bottom: 6, right: 10),
                            width: 50,
                            child: const Icon(
                              Icons.restart_alt_outlined,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Flexible(child: Obx(() {
              if (getSearchItemController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (getSearchItemController.allSearchedPost.isNotEmpty){
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: getSearchItemController.allSearchedPost.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            '${getSearchItemController.allSearchedPost[index].title}'),
                      );
                    },
                  );
                } else {
                  return  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
                        const Text("Sizning so'rvingiz bo'yicha\nmaʼlumot topilmadi", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                        Lottie.asset('assets/lottie/search.json', height: 200, width: 200,),
                      ],
                    ),
                  );
                }
              }
            })),
          ]),
        ),
      ),
    );
  }
}

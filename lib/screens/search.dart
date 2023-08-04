import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  String? ijaravalue = "ijaraYokiSotuv";
  String? viloyat = "Toshkent";
  String? valyuta = "So'm";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png', height: 40),
          backgroundColor: const Color(0xff008B51),
          centerTitle: true,
        ),
        body: Column(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                      child:SizedBox(
                        height: 43,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff008B51),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),),
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
                                borderRadius: BorderRadius.circular(6),
                                icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                                iconSize: 24,
                                style: const TextStyle(
                                    color: Color(0xff272727),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                items: const [
                                  DropdownMenuItem(
                                    value: "ijaraYokiSotuv",
                                    child: Text('Ijara yoki Sotuv'),
                                  ),
                                  DropdownMenuItem(
                                    value: "Ijara",
                                    child: Text('Ijara'),
                                  ),
                                  DropdownMenuItem(
                                    value: "Sotuv",
                                    child: Text('Sotuv'),
                                  )
                                ],
                                onChanged: (String? newIjara) {
                                  setState(() {
                                    ijaravalue = newIjara!;
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
                                icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                                iconSize: 24,
                                style: const TextStyle(
                                    color: Color(0xff272727),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                items: const [
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
                                    value: "Fargʻona",
                                    child: Text(
                                      'Fargʻona',
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
                                    value: "Qoraqalpogʻiston",
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
                                onChanged: (String? newViloyat) {
                                  setState(() {
                                    viloyat = newViloyat!;
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
                                icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                                iconSize: 24,
                                style: const TextStyle(
                                    color: Color(0xff272727),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                items: const [
                                  DropdownMenuItem(
                                    value: "So'm",
                                    child: Text("So'm"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Dollar",
                                    child: Text('Dollar'),
                                  ),
                                  DropdownMenuItem(
                                    value: "Yevro",
                                    child: Text('Yevro'),
                                  )
                                ],
                                onChanged: (String? newValyuta) {
                                  setState(() {
                                    valyuta = newValyuta!;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Text(
              "Search",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xff008B51),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

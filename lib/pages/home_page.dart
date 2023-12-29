import 'package:floating_menu_panel/floating_menu_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yyu_library/pages/author_pages.dart';
import 'package:yyu_library/pages/book_page.dart';
import 'package:yyu_library/pages/nfc_page.dart';
import 'package:yyu_library/widgets/book_card.dart';
import 'package:yyu_library/widgets/author_avatar.dart';
import 'package:yyu_library/widgets/category_container.dart';
import 'package:yyu_library/widgets/custom_text.dart';

import 'barcode_page.dart';
import 'category_page.dart';
import 'profil_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List pages = [Home(), BookPage(), CategoryPage(), AuthorPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions:  [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap:() {
                  Get.to(ProfilPage());
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/img/df.jpg"),
                ),
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          title: Row(
            children: [

              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: BorderRadius.circular(20)),
                  child: SearchBar(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.only(left: 10, right: 15)),
                    hintText: "Tara...",
                    backgroundColor: MaterialStatePropertyAll(Colors.red.shade900),
                    trailing: [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 4, 21, 31),
        extendBody: true,
        body:Stack(children: [
          pages[selectedIndex],
          FloatingMenuPanel(
            positionTop: 300,
            panelIcon: Icons.add,
              onPressed: (index) {
                index==0? App(context: context).scan():Get.to(NfcPage());
              },
              buttons: [
                Icons.qr_code_scanner,
                Icons.nfc_outlined
              ],
            ),
        ],) ,
        bottomNavigationBar: GNav(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;

              });
            },
            haptic: true,
            tabBorderRadius: 5,
            tabShadow: [
              BoxShadow(color: Color.fromARGB(255, 4, 21, 31), blurRadius: 80, spreadRadius: 20)
            ],
            curve: Curves.bounceIn,
            duration: Duration(milliseconds: 500),
            color: Colors.white,
            activeColor: Colors.white,
            iconSize: 30,
            tabBackgroundColor: Colors.red.shade900,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            tabs: const [
              GButton(
                icon: Icons.home_sharp,
                text: 'Anasayfa',
              ),
              GButton(
                icon: Icons.menu_book,
                text: 'Kitaplar',
              ),
              GButton(
                icon: Icons.category,
                text: 'Kategoriler',
              ),
              GButton(
                icon: Icons.local_library_outlined,
                text: 'Yazarlar',
              )
            ]));
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.4,0.9],
              colors: [
                Color.fromARGB(255, 4, 21, 31),
                Colors.blueGrey,
              ])
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10),
        child: ListView(
          children: [
            AuthorAvatar(),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  CustomText(
                    text: "Popüler Kitaplar",
                    size: 15,
                    color: Colors.white70,
                  ),
                  Expanded(
                      child: Divider(
                        color: Colors.white70,
                    height: 20,
                    thickness: 2,
                    indent: 10,
                    endIndent: 20,
                  ))
                ],
              ),
            ),
            BookCard(),
            Padding(
              padding: const EdgeInsets.only(bottom: 7, left: 10),
              child: Row(
                children: [
                  CustomText(
                    text: "Kategoriler",
                    size: 15,
                    color: Colors.white70,
                  ),
                  Expanded(
                      child: Divider(
                        color: Colors.white70,
                    height: 20,
                    thickness: 2,
                    indent: 10,
                    endIndent: 20,
                  ))
                ],
              ),
            ),
            CategoryContainer(),
          ],
        ),
      ),
    );
  }
}



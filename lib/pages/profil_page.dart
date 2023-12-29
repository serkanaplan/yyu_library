import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_panel_plus/flip_panel_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:yyu_library/models/book_model.dart';
import 'package:yyu_library/models/lending_model.dart';
import 'package:yyu_library/repo/book_repo.dart';
import 'package:yyu_library/repo/lending_repo.dart';
import 'package:yyu_library/repo/user_repo.dart';
import 'package:yyu_library/widgets/custom_text.dart';
import '../models/user_model.dart';
import 'dart:math';

class ProfilPage extends StatefulWidget {
  ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Future<Users> user = UserRepo().getUserById();
  int selectedIndex = 0;
  Future<Lending> lending = LendingRepo().getLendingById();
   BookRepo bookrepo = BookRepo();
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 4, 21, 31),
        appBar: AppBar(
          title: CustomText(
            text: "Serkan Kaplan",
            color: Colors.white,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: user,
          builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: 300,
                        height: 300,
                        margin: EdgeInsets.only(bottom: 1),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.red,
                                blurRadius: 200,
                                spreadRadius: 20),
                          ],
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  snapshot.data!.userImg),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: FutureBuilder(
                        future: lending,
                        builder: (BuildContext context,
                            AsyncSnapshot<Lending> data) {
                          return Column(
                            children: [
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: AnimatedContainer(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: isExpanded ? 30 : 0,
                                    vertical: 20,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  height: isExpanded ? 98 : 330,
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  duration: Duration(milliseconds: 1200),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.9),
                                        blurRadius: 20,
                                        offset: Offset(5, 10),
                                      ),
                                    ],
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(isExpanded ? 20 : 20),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FlipClockPlus.reverseCountdown(
                                            duration: const Duration(days: 10),
                                            digitColor: Colors.white,
                                            backgroundColor: Colors.black,
                                            digitSize: 30.0,
                                            centerGapSpace: 0.0,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3.0)),
                                            onDone: () {
                                              print('onDone');
                                            },
                                          ),
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_down
                                                : Icons.keyboard_arrow_up,
                                            color: Colors.white,
                                            size: 27,
                                          ),
                                        ],
                                      ),
                                      isExpanded
                                          ? SizedBox()
                                          : SizedBox(height: 20),
                                      AnimatedCrossFade(
                                        firstChild: Text(
                                          '',
                                          style: TextStyle(
                                            fontSize: 0,
                                          ),
                                        ),
                                        secondChild: Row(
                                          children: [
                                            Text(
                                              snapshot.data.
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.7,
                                              ),
                                            ),
                                          ],
                                        ),
                                        crossFadeState: isExpanded
                                            ? CrossFadeState.showFirst
                                            : CrossFadeState.showSecond,
                                        duration: Duration(milliseconds: 1200),
                                        reverseDuration: Duration.zero,
                                        sizeCurve:
                                            Curves.fastLinearToSlowEaseIn,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AnimCard(Colors.redAccent, data),
                              AnimCard(Colors.blueAccent, data),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
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
              BoxShadow(
                  color: Color.fromARGB(255, 4, 21, 31),
                  blurRadius: 80,
                  spreadRadius: 20)
            ],
            curve: Curves.bounceIn,
            duration: Duration(milliseconds: 500),
            color: Colors.white,
            activeColor: Colors.white,
            iconSize: 30,
            tabBackgroundColor: Colors.red.shade900,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            tabs: const [
              GButton(
                icon: Icons.book_outlined,
                text: 'Aldıklarım',
              ),
              GButton(
                icon: Icons.check,
                text: 'Okuduklarım',
              ),
            ]));
  }
}

class AnimCard extends StatefulWidget {
  final Color color;
  final AsyncSnapshot<Lending> data;
  BookRepo bookrepo = BookRepo();

  AnimCard(this.color, this.data);

  @override
  _AnimCardState createState() => _AnimCardState();
}

class _AnimCardState extends State<AnimCard> {
  var padding = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: AnimatedPadding(
              padding: EdgeInsets.only(left: padding),
              duration: Duration(milliseconds: 1000),
              curve: Curves.linearToEaseOut,
              child: Container(
                child: CardItem(
                  widget.color,
                  "1",
                  "sr",
                  "widget",
                  () {
                    setState(
                      () => padding = padding == 0 ? 100.0 : 0.0,
                    );
                  },
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipPath(
                clipper: ArcClipper(),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                    child: Container(
                      child: widget.data.data != null
                          ? FutureBuilder(
                              future: widget.bookrepo
                                  .getBookById(widget.data.data!.bookId!),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Book> bookdata) {
                                return FittedBox(
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: "- Kalan Süre -",
                                        size: 20,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          FlipClockPlus.reverseCountdown(
                                            duration: const Duration(days: 10),
                                            digitColor: Colors.white,
                                            backgroundColor: Colors.black,
                                            digitSize: 30.0,
                                            centerGapSpace: 0.0,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3.0)),
                                            onDone: () {
                                              print('onDone');
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              })
                          : Text(''),
                      height: 80,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final Color color;
  final String num;
  final String numEng;
  final String content;
  final onTap;

  CardItem(this.color, this.num, this.numEng, this.content, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: color.withOpacity(0.5),
          height: 100,
          width: 300,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: color.withOpacity(1),
                ),
                child: Icon(Icons.arrow_back_ios_new),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  num,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    var arcPath = Path.combine(
      PathOperation.difference,
      path,
      Path()
        ..addArc(
          Rect.fromCircle(
            center: Offset(0, size.height / 2),
            radius: size.height / 3,
          ),
          0,
          2 * pi,
        ),
    );
    return arcPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

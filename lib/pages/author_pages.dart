import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import '../models/book_model.dart';
import '../repo/book_repo.dart';

class AuthorPage extends StatelessWidget {
  AuthorPage({super.key});
  Future<List<Book>> bookRepo = BookRepo.getBooks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 21, 31),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
              0.2,
              0.9
            ],
                colors: [
              Color.fromARGB(255, 4, 21, 31),
              Colors.blueGrey,
            ])),
        child: AlignedGridView.count(
          itemCount: 15,
          itemBuilder: (context, index) => FutureBuilder(
            future: bookRepo,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.black,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.bottomCenter,
                    width: 130,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white12, width: 3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Hata: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: BackdropFilter(
                        blendMode: BlendMode.luminosity,
                        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                        child: Container(
                          margin: EdgeInsets.all(9),
                          alignment: Alignment.bottomCenter,
                          width: 130,
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 3),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(snapshot
                                      .data![index].author["author_img"]),
                                  fit: BoxFit.cover)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30)),
                            child: BackdropFilter(
                              blendMode: BlendMode.luminosity,
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                padding: EdgeInsets.only(top: 5),
                                height: 60,
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  height: 15,
                                  width: 90,
                                  child: Marquee(
                                    text: snapshot.data![index].author["name"],
                                    style: TextStyle(fontSize: 12),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    velocity: 20.0,
                                    fadingEdgeStartFraction: 1,
                                    fadingEdgeEndFraction: 0.1,
                                    startPadding: 10.0,
                                    accelerationDuration: Duration(seconds: 1),
                                    accelerationCurve: Curves.ease,
                                    decelerationDuration:
                                        Duration(milliseconds: 500),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 25,
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(color: Colors.red.shade900, blurRadius: 40)
                        ]),
                        child: RatingBar.builder(
                          itemSize: 18,
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Text(
                    'Veri bulunamadı'); // Null bir değer yerine bir hata mesajı göster
              }
            },
          ),
          crossAxisCount: 3,
        ),
      ),
    );
  }
}

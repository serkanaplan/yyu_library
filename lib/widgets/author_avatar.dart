import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yyu_library/models/book_model.dart';
import 'package:yyu_library/repo/book_repo.dart';
import 'package:yyu_library/widgets/custom_text.dart';

class AuthorAvatar extends StatefulWidget {
  AuthorAvatar({super.key});

  @override
  State<AuthorAvatar> createState() => _AuthorAvatarState();
}

class _AuthorAvatarState extends State<AuthorAvatar> {
   late Future<List<Book>> bookRepo;

@override
  void initState() {
    bookRepo=BookRepo.getBooks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<Book>>(
        future: bookRepo,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Row(
                children: List.generate(
                    6,
                    (index) => Shimmer.fromColors(
                        baseColor: Colors.black12,
                        highlightColor: Colors.black,
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 2, left: 3, right: 5),
                            child: Container(
                                width: 75,
                                height: 75,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                        color: Colors.blue, width: 3),
                                    borderRadius:
                                        BorderRadius.circular(40)))))));
          }
          if (snapshot.hasError) {
            return Text(
                'Resimler yüklenirken bir hata oluştu: ${snapshot.error}');
          }
          return Row(
            children: List.generate(
                snapshot.data!.length,
                (index) {
                 return Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          blendMode: BlendMode.luminosity,
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 2, left: 3, right: 5),
                            child: Container(
                              width: 75,
                              height:75,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blue, width: 3),
                                  borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(snapshot.data![index].author["author_img"]),fit: BoxFit.cover
                              )),


                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 60,
                        child: Marquee(
                          text: snapshot.data![index].author["name"],
                          style: TextStyle(fontSize: 12),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          velocity: 20.0,
                          fadingEdgeStartFraction: 1,
                          fadingEdgeEndFraction: 0.1,
                          startPadding: 10.0,
                          accelerationDuration: Duration(seconds: 1),
                          accelerationCurve: Curves.ease,
                          decelerationDuration: Duration(milliseconds: 500),
                        ),
                      )
                    ],
                  );

                }),
          );
        },
      ),
    );
  }
}

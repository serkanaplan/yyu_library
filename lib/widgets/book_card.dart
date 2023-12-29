import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:math';
import 'package:yyu_library/repo/book_repo.dart';
import 'package:yyu_library/widgets/custom_text.dart';
import '../models/book_model.dart';


class BookCard extends StatefulWidget {
  @override
  _BookCardState createState() => _BookCardState();
}


class _BookCardState extends State<BookCard> {
  late final Future<List<Book>> bookrepo;
  double _page = 10;

@override
  void initState() {
    bookrepo=BookRepo.getBooks();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PageController pageController;
    pageController = PageController(initialPage: 10);
    pageController.addListener(
      () {
        setState(
          () {
            _page = pageController.page!;
          },
        );
      },
    );

    return FutureBuilder<List<Book>>(
      future: bookrepo,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Center(
        child: Stack(
          children: [
            SizedBox(
              height: width - 15,
              width: width * .9,
              child:snapshot.connectionState==ConnectionState.waiting?LayoutBuilder(
                builder: (context, boxConstraints) {
                  List<Widget> cards = [];

                  for (int i = 0; i < 10; i++) {
                    double currentPageValue = i - _page;
                    bool pageLocation = currentPageValue > 0;

                    double start = 20 +
                        max(
                            (boxConstraints.maxWidth - width * .75) -
                                ((boxConstraints.maxWidth - width * .75) / 2) *
                                    -currentPageValue *
                                    (pageLocation ? 10 : 0.9),
                            0.0);

                    var customizableCard = Positioned.directional(
                      top: 20 + 30 * max(-currentPageValue, 0.0),
                      bottom: 20 + 30 * max(-currentPageValue, 0.0),
                      start: start,
                      textDirection: TextDirection.ltr,
                      child: Container(
                          height: width * .67,
                          width: width * .67,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(-10, 10),
                                    color: Colors.white12,
                                    blurRadius: 10)
                              ]),
                         ),
                    );
                    cards.add(customizableCard);
                  }
                  return Stack(children: cards);
                },
              ): LayoutBuilder(
                builder: (context, boxConstraints) {
                  List<Widget> cards = [];

                  for (int i = 0; i < 10; i++) {
                    double currentPageValue = i - _page;
                    bool pageLocation = currentPageValue > 0;

                    double start = 20 +
                        max(
                            (boxConstraints.maxWidth - width * .75) -
                                ((boxConstraints.maxWidth - width * .75) / 2) *
                                    -currentPageValue *
                                    (pageLocation ? 10 : 0.9),
                            0.0);

                    var customizableCard = Positioned.directional(
                      top: 20 + 30 * max(-currentPageValue, 0.0),
                      bottom: 20 + 30 * max(-currentPageValue, 0.0),
                      start: start,
                      textDirection: TextDirection.ltr,
                      child: Container(
                          height: width * .67,
                          width: width * .67,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      CachedNetworkImageProvider(snapshot.data[i].book_img),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(-10, 10),
                                    color: Colors.white12,
                                    blurRadius: 10)
                              ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                height: 100,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomText(text:snapshot.data[i].title,size: 20,),
                                    CustomText(text:snapshot.data[i].author["name"],color: Colors.green,),
                                    RatingBar.builder(
                                      itemSize: 20,
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.white
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    );
                    cards.add(customizableCard);
                  }
                  return Stack(children: cards);
                },
              ),
            ),
            Positioned.fill(
              child: PageView.builder(
                itemCount: 10,
                controller: pageController,
                itemBuilder: (BuildContext context, int index) {
                  return Row();
                },
              ),
            ),
          ],
        ),
      );
      },
    );
  }
}

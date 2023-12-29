import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/route_manager.dart';
import 'package:yyu_library/models/book_model.dart';
import 'package:yyu_library/widgets/custom_text.dart';

class BookDetail extends StatefulWidget {
  BookDetail({super.key});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late final Book data;
  @override
  void initState() {
    data = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Kitap Detayı",
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.favorite),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 3, 7, 30),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CustomText(
                      text: data.title,
                      color: Colors.green,
                      size: 15,
                    ),
                    CustomText(text: data.author["name"]),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(9),
                  alignment: Alignment.bottomCenter,
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                          image: NetworkImage(data.book_img),
                          fit: BoxFit.cover)),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Positioned(
                        bottom: 10,
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(blurRadius: 25, color: Colors.black)
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
                              color: Colors.yellow,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  Icon(Icons.chrome_reader_mode_outlined),
                  CustomText(text: "Reads"),
                  CustomText(text: "5.1M",color: Colors.yellow,)
                  
                ],),
                 Column(children: [
                   Icon(Icons.thumb_up),
                  CustomText(text: "Likes"),
                  CustomText(text: "5.1M",color: Colors.yellow,)
                 ],),
                  Column(children: [
                     Icon(Icons.category_outlined),
                  CustomText(text: "Category"),
                  CustomText(text: "Roman",color: Colors.yellow,)
                  ],)
              ],
            ),
            CustomText(text: data.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red.shade900)),

                    onPressed: (){},
                    icon: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 50,
                    ),
                    label: CustomText(text: "Qr",color: Colors.white,size: 20,)),
                ElevatedButton.icon(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green.shade900)),
                    onPressed: (){},
                    icon: Icon(
                      Icons.nfc_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                    label: CustomText(text: "nfc",color: Colors.white,size: 20,))
              ],
            )
          ],
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yyu_library/widgets/custom_text.dart';

import '../models/book_model.dart';
import '../repo/book_repo.dart';

// ignore: must_be_immutable
class CategoryContainer extends StatelessWidget {
  Future<List<Book>> bookRepo=BookRepo.getBooks();
  List<String> categorylist = [
    "Roman",
    "Bilim-Kurgu",
    "Tarih",
    "Biyografi",
    "Şiir",
    "Din-Mitoloji",
    "Psikoloji",
    "Komedi",
    "Anı",
    "Hikaye",
    "Edebiyat"
  ];

  CategoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: MasonryGridView.builder(
        itemCount: categorylist.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(2),
            child: InkWell(
              child: Container(
                  alignment: Alignment.center,
                  width: categorylist[index].length *
                      13, //index%2==1?space/2:space/5,
                  decoration: BoxDecoration(
                      boxShadow: const [
                      ],

                      color: Colors.blueGrey.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(40)),
                  child: CustomText(
                      text: categorylist[index], color: Colors.white)),
              onTap: () {},
            ),
          );
        },
        gridDelegate:
            SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}

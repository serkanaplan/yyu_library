import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:yyu_library/widgets/custom_text.dart';
import '../models/book_model.dart';
import '../repo/book_repo.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  Future<List<Book>> bookRepo = BookRepo.getBooks();
  List<String> img=["ampul","cicek","gece","korku","orman","tarih","yemek","yildiz","yoga",];
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
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
        child: FutureBuilder(
          future: bookRepo,
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: img.length-1,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: FadeInAnimation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(milliseconds: 2500),
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          height: _w / 4,
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(opacity: 0.5,
                                image: AssetImage("assets/img/${img[index]}.jpeg"),
                                fit: BoxFit.cover),
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: CustomText(text: snapshot.data![index].category,color: Colors.white,size: 30,),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        ),
      ),
    );
  }
}

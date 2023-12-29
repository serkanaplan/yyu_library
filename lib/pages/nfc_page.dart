import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../models/book_model.dart';
import '../repo/book_repo.dart';
import '../widgets/custom_text.dart';

class NfcPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NfcPageState();
}

class NfcPageState extends State<NfcPage> {
  ValueNotifier<Book> result = ValueNotifier<Book>(
    Book(
      id: "",
      author: {},
      category: "",
      description: "",
      isbn: "",
      nfc_id: "",
      book_img: "",
      number_of_likes: 0,
      status: false,
      stok: 0,
      title: "",
    ),
  );

  @override
  void initState() {
    _tagRead();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 3, 7, 30),
      appBar: AppBar(title: Text('Kitap Detay',style: TextStyle(color: Colors.white),),backgroundColor: Colors.transparent,),
      body: SingleChildScrollView(
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) => ss.data != true
              ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder<Book>(
                          valueListenable: result,
                          builder: (context, data, child) {
                            return data.title.isEmpty?

                                Image.network(
                                  data.book_img,
                                  width: 200,
                                  errorBuilder: (context, error, stackTrace) =>
                                      LottieBuilder.asset("assets/img/nfc.json"),
                                ):

                            Padding(
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
                                            width: 150,
                                            height: 250,
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
                                      SizedBox(height: 20,),
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                                        child: CustomText(text: data.description),
                                      ),
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
                            );

                          }),

                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _tagRead() async {
    await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      String nfcId = tag.data["nfcv"]["identifier"].toString();
      print(nfcId);
      NfcManager.instance.stopSession();
      result.value = await BookRepo().getBookByNFCId(nfcId);
    });
  }
}
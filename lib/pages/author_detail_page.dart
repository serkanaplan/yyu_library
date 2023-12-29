import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:yyu_library/pages/book_page.dart';
import 'package:yyu_library/widgets/custom_text.dart';

class AuthorDetail extends StatefulWidget {
  const AuthorDetail({super.key});

  @override
  State<AuthorDetail> createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isExpanded = false;
  bool isFavorite = false;
    var books = 7;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Yazar Detayı",
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            child: Transform.translate(
              offset: Offset(_animation.value, 0),
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : null,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 3, 7, 30),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.brown.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2023/12/14/18/07/ai-generated-8449431_1280.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Transform.translate(
                offset: Offset(0, _animation.value),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text("Lev Tolstoy"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: const Column(
                            children: [
                              Icon(Icons.chrome_reader_mode_outlined),
                              Text("Reads"),
                              Text("4.5M")
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Transform.translate(
                          offset: Offset(0, _animation.value),
                          child: const Column(
                            children: [
                              Icon(Icons.thumb_up),
                              Text("Likes"),
                              Text("3.7M"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Transform.translate(
                          offset: Offset(0, _animation.value),
                          child:  Column(
                            children: [
                              const Icon(Icons.menu_book_sharp),
                              Text("books"),
                              Text(books.toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              /* Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform.translate(
                  offset: Offset(0, _animation.value),
                  child: ExpansionTile(
                    trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    title: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Text(
                        "Leo Tolstoy (1828-1910)",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Leo Tolstoy (1828-1910) is recognized as a Russian writer, philosopher, and social reformer. Despite coming from a noble family, Tolstoy developed a profound concern for social justice and the difficult situation of peasants, gaining fame for his epic novels War and Peace and Anna Karenina. Tolstoy's literary career began with autobiographical works such as Childhood, Boyhood, and Youth. However, it was his later works that earned him international acclaim. Published between 1865 and 1869, War and Peace is considered one of the greatest novels, depicting the Napoleonic era through the lives of several noble families. Anna Karenina, published between 1873 and 1877, explores themes of love, morality, and societal expectations.",
                          ),
                        ),
                      ),
                    ],
                  ), 
                ),
              ), */

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
                    horizontal: isExpanded ? 25 : 0,
                    vertical: 20,
                  ),
                  padding: EdgeInsets.all(20),
                  height: isExpanded ? 70 : 350,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 1200),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 20,
                        offset: Offset(5, 10),
                      ),
                    ],
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(isExpanded ? 20 : 20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Leo Tolstoy (1828-1910)",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w400,
                            ),
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
                      isExpanded ? SizedBox() : SizedBox(height: 20),
                      AnimatedCrossFade(
                        firstChild: Text(
                          'hello',
                          style: TextStyle(
                            fontSize: 0,
                          ),
                        ),
                        secondChild: const Text(
                          "Leo Tolstoy (1828-1910) is recognized as a Russian writer, philosopher, and social reformer. Despite coming from a noble family, Tolstoy developed a profound concern for social justice and the difficult situation of peasants, gaining fame for his epic novels War and Peace and Anna Karenina. Tolstoy's literary career began with autobiographical works such as Childhood, Boyhood, and Youth. However, it was his later works that earned him international acclaim..",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: Duration(milliseconds: 1200),
                        reverseDuration: Duration.zero,
                        sizeCurve: Curves.fastLinearToSlowEaseIn,
                      ),
                    ],
                  ),
                ),
              ),
              /* ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueGrey)),
                  onPressed: () {
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) => BookPage()));
                  },
                  icon: const Icon(
                    Icons.menu_book_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                  label: CustomText(
                    text: "Books",
                    color: Colors.white,
                    size: 20,
                  )), */

              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, 
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: books,
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // GridView'in scroll yapmasını engeller
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2012/10/10/05/04/train-60539_1280.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

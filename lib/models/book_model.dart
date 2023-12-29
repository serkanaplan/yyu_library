class Book {
    final String id;
    final Map<String,dynamic> author;
    final String category;
    final String description;
    final String isbn;
    final String nfc_id;
    final String book_img;
    final int number_of_likes;
    final bool status;
    final int stok;
    final String title;

    Book({
      required String this.id,
        required this.author,
        required this.category,
        required this.description,
        required this.isbn,
        required this.nfc_id,
        required this.book_img,
        required this.number_of_likes,
        required this.status,
        required this.stok,
        required this.title,

    });

    factory Book.fromJson(Map<String, dynamic> json,String id) => Book(
      id: id,
        author: json["author"],
        category: json["category"],
        description: json["description"],
        isbn: json["isbn"],
      nfc_id: json["nfc_id"],
        book_img: json["book_img"],
        number_of_likes: json["number_of_likes"],
        status: json["status"],
        stok: json["stok"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "author": author,
        "category": category,
        "description": description,
        "isbn": isbn,
        "nfc_id": nfc_id,
        "book_img": book_img,
        "number_of_likes": number_of_likes,
        "status": status,
        "stok": stok,
        "title": title,

    };
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yyu_library/models/book_model.dart';
import 'package:yyu_library/services/firestore_service.dart';

class BookRepo {
  static FirestoreDb _data = FirestoreDb();

  static Future<List<Book>> getBooks() async {
    var bookData = await _data.getBooks();

    if (bookData.docs.isNotEmpty) {
      List<Book> bookList = bookData.docs.map((doc) {
        final data = doc.data();
        return Book.fromJson(data, doc.id);
      }).toList();
      return bookList;
    } else {
      return [];
    }
  }

  Future<Book> getBookByIsbn(String isbn) async {
    var bookdata = await _data.getBookByIsbn(isbn);

    var book =
        Book.fromJson(bookdata.docs.first.data(), bookdata.docs.first.id);
    return book;
  }

  Future<Book> getBookByNFCId(String nfcid) async {
    QueryDocumentSnapshot<Map<String, dynamic>> bookdata =
        await _data.getBookByNFCId(nfcid);
    return Book.fromJson(bookdata.data(), bookdata.id)?? Book(  id: "", author: {},  category: "",  description: "",  isbn: "",  nfc_id: "",  book_img: "",  number_of_likes: 0,  status: false,  stok: 0,  title: "",);
  }

  Future<Book> getBookById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> bookdata =
        await _data.getBookById(id);

    Book book = Book.fromJson(bookdata.data()!, bookdata.id);
    return book;
  }
}

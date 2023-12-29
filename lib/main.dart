import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';
import 'package:yyu_library/pages/home_page.dart';
import 'package:yyu_library/pages/login_page.dart';
import 'package:yyu_library/pages/profil_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobil Kutuphane',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
        searchBarTheme: const SearchBarThemeData(
            textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.white)),
            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
            hintStyle:
                MaterialStatePropertyAll(TextStyle(color: Colors.white))),
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),//değişecek
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        fontFamily: "Baumans",
        useMaterial3: true,
      ),
      home: ProfilPage(),
    );
  }
}


class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _authorImgController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _authorLikesController = TextEditingController();
  final TextEditingController _bookImgController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _likesController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _authorImgController.dispose();
    _authorNameController.dispose();
    _authorLikesController.dispose();
    _bookImgController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _isbnController.dispose();
    _likesController.dispose();
    _statusController.dispose();
    _stockController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String id = _idController.text;
      String authorImg = _authorImgController.text;
      String authorName = _authorNameController.text;
      int authorLikes = int.parse(_authorLikesController.text);
      String bookImg = _bookImgController.text;
      String category = _categoryController.text;
      String description = _descriptionController.text;
      String isbn = _isbnController.text;
      int likes = int.parse(_likesController.text);
      bool status = _statusController.text.toLowerCase() == 'true';
      int stock = int.parse(_stockController.text);
      String title = _titleController.text;

      // Firestore'a veri ekleme
      FirebaseFirestore.instance.collection('books').doc(id).set({
        'author': {
          'author_img': authorImg,
          'name': authorName,
          'number_of_likes': authorLikes,
        },
        'book_img': bookImg,
        'category': category,
        'description': description,
        'isbn': isbn,
        'number_of_likes': likes,
        'status': status,
        'stok': stock,
        'title': title,
      });
      // Formu sıfırla
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                cursorColor: Colors.red,
                controller: _idController,
                decoration: InputDecoration(labelText: 'Kitap Id',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ' id alanı boş olamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorImgController,
                decoration: InputDecoration(labelText: 'Yazar Resmi'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Yazar resmi alanı boş olamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorNameController,
                decoration: InputDecoration(labelText: 'Yazar Adı'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Yazar adı alanı boş olamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _authorLikesController,
                decoration: InputDecoration(labelText: 'Yazar Beğenileri'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Yazar beğenileri alanı boş olamaz';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Yazar beğenileri alanı bir sayı olmalıdır';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bookImgController,
                decoration: InputDecoration(labelText: 'Kitap Resmi'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kitap resmi alanı boş olamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Kategori'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kategori alanı boş olamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Açıklama'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Açıklama alanı boş olamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isbnController,
                decoration: InputDecoration(labelText: 'ISBN'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'ISBN alanı boş olamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _likesController,
                decoration: InputDecoration(labelText: 'Beğeniler'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Beğeniler alanı boş olamaz';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Beğeniler alanı bir sayı olmalıdır';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Durum'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Durum alanı boş olamaz';
                  }
                  if (value!.toLowerCase() != 'true' &&
                      value!.toLowerCase() != 'false') {
                    return 'Durum alanı "true" veya "false" olmalıdır';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stok'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Stok alanı boş olamaz';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Stok alanı bir sayı olmalıdır';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Başlık'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Başlık alanı boş olamaz';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Kaydet'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

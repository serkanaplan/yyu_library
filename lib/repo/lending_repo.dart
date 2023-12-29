import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yyu_library/main.dart';
import 'package:yyu_library/models/book_model.dart';
import 'package:yyu_library/models/lending_model.dart';
import 'package:yyu_library/models/user_model.dart';
import 'package:yyu_library/services/firebase_auth_service.dart';
import 'package:yyu_library/services/firestore_service.dart';

class LendingRepo {
  User? auth = FirebaseAuthservice.user;
  Timestamp timestamp = Timestamp.now();
  FirestoreDb _data = FirestoreDb();

  Future<List<Lending>> getLendings() async {
    var userdata = await _data.getLendings();

    if (userdata.docs.isNotEmpty) {
      List<Lending> lendingList = userdata.docs.map((doc) {
        final data = doc.data();
        return Lending.fromJson(data, doc.id);
      }).toList();
      return lendingList;
    } else {
      return [];
    }
  }

    Future<Lending> getLendingById() async {
   User? authuser = FirebaseAuthservice.user; 
   QueryDocumentSnapshot<Map<String, dynamic>>  lending=await _data.getLendingById(authuser!.uid);
    return Lending.fromJson(lending.data(), lending.id);
  }

  Future<void> addLending(String bookid) async {
    if (auth != null) {
      String uid = auth!.uid;
      print("/////////////////////////////////////");
      print(uid);
      Lending lending = Lending(
        bookId: bookid,
        sysReturnDate: Timestamp.fromDate(
            timestamp.toDate().add(const Duration(days: 15))),
        transactionDate: timestamp,
        transactionType: true,
        userId: uid,
      );
      await _data.addLending(lending);
    } else {
      print('Kullanıcı oturum açmamış.');
    }
  }

 
}

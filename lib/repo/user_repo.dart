import 'package:firebase_auth/firebase_auth.dart';
import 'package:yyu_library/services/firestore_service.dart';
import 'package:yyu_library/models/user_model.dart';

import '../services/firebase_auth_service.dart';

class UserRepo {
  
  FirestoreDb  _data=FirestoreDb();

  Future<List<Users>> getAllUser() async {
   var userdata =await _data.getUsers();
  
   if ( userdata.docs.isNotEmpty) {
     List<Users> userlist= userdata.docs.map((doc) {
      final data=doc.data();
      return Users.fromJson(data,doc.id);
     }).toList();
     print(userlist[0]);
     return userlist;
   }
else{
  return [];
}
}

Future<Users> getUserById() async {
   User? authuser = FirebaseAuthservice.user; 
   var user=await _data.getUsersById(authuser!.uid);
    return Users.fromJson(user.data()!, user.id);
}
}
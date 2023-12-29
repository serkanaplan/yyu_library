import 'package:cloud_firestore/cloud_firestore.dart';

class Lending {
  String? id;
  String? bookId;
  int? renewalCount;
  Timestamp? sysReturnDate;
  Timestamp? transactionDate;
  bool? transactionType;
  String? userId;
  Timestamp? userReturnDate;

  Lending(
      {
      this.id,  
      this.bookId,
      this.renewalCount,
      required this.sysReturnDate,
      this.transactionDate,
      this.transactionType,
      this.userId,
      this.userReturnDate});

  Lending.fromJson(Map<String, dynamic> json,String id) {
    id=id;
    bookId = json['bookId'];
    renewalCount = json['renewalCount'];
    sysReturnDate = json['sysReturnDate'];
    transactionDate = json['transactionDate'];
    transactionType = json['transactionType'];
    userId = json['user_id'];
    userReturnDate = json['userReturnDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookId'] = this.bookId;
    data['renewalCount'] = this.renewalCount;
    data['sysReturnDate'] = this.sysReturnDate;
    data['transactionDate'] = this.transactionDate;
    data['transactionType'] = this.transactionType;
    data['userId'] = this.userId;
    data['userReturnDate'] = this.userReturnDate;
    return data;
  }
}

import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:yyu_library/repo/book_repo.dart';
import 'package:yyu_library/repo/lending_repo.dart';
import 'package:yyu_library/repo/user_repo.dart';
import '../models/user_model.dart';
import '../services/firebase_auth_service.dart';


class App {
  ScanResult? scanResult;
  BuildContext context;
  App({required this.context});
  List<BarcodeFormat> selectedFormats = [
    BarcodeFormat.code39,
    BarcodeFormat.ean13
  ];
  BookRepo bookRepo = BookRepo();
  LendingRepo lendingRepo = LendingRepo();
  User? auth = FirebaseAuthservice.user;
  Future<List<Users>> userRepo = UserRepo().getAllUser();
  Future<void> scan() async {
    if (auth != null) {
      try {
        final result = await BarcodeScanner.scan(
          options: ScanOptions(
            restrictFormat: selectedFormats,
            useCamera: -1,
            autoEnableFlash: false,
            android: const AndroidOptions(
              useAutoFocus: true,
            ),
          ),
        );
        var book = await bookRepo.getBookByIsbn(result.rawContent);
        // ignore: use_build_context_synchronously
        AwesomeDialog(
            customHeader: Image.network(book.book_img, fit: BoxFit.fill),
            dialogBackgroundColor: Colors.black,
            context: context,
            dialogType: DialogType.question,
            headerAnimationLoop: false,
            animType: AnimType.topSlide,
            title: book.title,
            desc: book.description,
            btnCancelOnPress: () {},
            btnOkOnPress: () async {
              if (book.stok != 0) {}
              await lendingRepo.addLending(book.id);
              Get.snackbar("işlem başarılı", "message", icon: Icon(Icons.done));
            }).show();
      } on PlatformException catch (e) {
        scanResult = ScanResult(
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      }
    } else {
      AwesomeDialog(
        dialogBackgroundColor: Colors.black,
        context: context,
        animType: AnimType.bottomSlide,
        dialogType: DialogType.info,
        title: "title",
        desc: "msg",
        btnOkIcon: Icons.check_circle,
        btnOkColor: Colors.green.shade900,
        btnOkOnPress: () {},
      ).show();
    }
  }
}

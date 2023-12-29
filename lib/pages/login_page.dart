import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yyu_library/pages/home_page.dart';
import 'package:yyu_library/services/firebase_auth_service.dart';
import 'package:yyu_library/widgets/custom_text.dart';
import 'package:yyu_library/widgets/custom_textformfield.dart';
import '../widgets/custom_sliderbutton.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.4,1],
                colors: [
                  Color.fromARGB(255,4, 21, 31),
                  Colors.blueGrey,

                ]),
          ),
          alignment: Alignment.center,
          child: Wrap(
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              CustomText(text: "Mobil Kütüphane", size: 50),
              const Divider(
                height: 5,
                indent: 15,
                endIndent: 15,
              ),
              Shimmer.fromColors(
                  baseColor: Colors.white38,
                  highlightColor: Colors.white,
                  child: Image.asset(
                    "assets/img/yyu.png",
                    width: 200,
                    height: 200,
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextFormField(
                        controller: _usernameController,
                        icon: Icons.person,
                        labeltext: "Öğrenci ID",
                      ),
                      const SizedBox(height: 15),
                      CustomTextFormField(
                        controller: _passwordController,
                        icon: Icons.password,
                        labeltext: "Şifre",
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomSliderButton(
                            onsubmit: () async {
                              if (_formKey.currentState!.validate()) {
                                await FirebaseAuthservice.signIn(
                                        email: _usernameController.text,
                                        password: _passwordController.text)
                                    .then((value) {
                                  value == null
                                      ? Get.to(HomePage(), transition:Transition.size)
                                      : Get.snackbar(
                                        overlayBlur: 10,
                                        padding:  EdgeInsets.all(20),
                                        icon:Icon(Icons.report_gmailerrorred_rounded,size: 50),
                                          'Kullanıcı Bulunamadı',
                                          'Öğrenci ID veya Şifre yanlış girilmiş olabilir',
                                          backgroundColor: Colors.red[900],
                                          colorText: Colors.white,
                                          borderRadius:10.0,
                                          duration: Duration(seconds: 3));
                                });
                              }
                            },
                            width: 150,
                            text: "Giriş Yap",
                            color: Colors.green,
                            icon: Icons.arrow_forward_ios_sharp,
                            action: () => Get.to(HomePage()),
                          ),
                          CustomSliderButton(
                              onsubmit: () async{
                                Get.to(HomePage(),transition: Transition.size);
                              },
                              width: 170,
                              text: "Misafir Girişi",
                              color: Colors.red,
                              icon: Icons.waving_hand_outlined,
                              action: () => print("hello")),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomText(
                          text:
                              "Copyright © 2020 Bilgisayar Bilimleri Araştırma ve Uygulama Merkezi",
                          color: Colors.white,
                          size: 10)
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

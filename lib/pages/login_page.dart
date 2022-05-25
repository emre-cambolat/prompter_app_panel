import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prompter_app_panel/components/app_colors.dart';
import 'package:prompter_app_panel/components/loading_indicator.dart';
import 'package:prompter_app_panel/pages/home_page.dart';

class LoginPageUI extends StatefulWidget {
  const LoginPageUI({Key? key}) : super(key: key);

  @override
  State<LoginPageUI> createState() => _LoginPageUIState();
}

class _LoginPageUIState extends State<LoginPageUI> {
  late TextEditingController _tcMail;
  late TextEditingController _tcPass;
  late double _scHeight;
  late double _scWidth;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _tcMail = TextEditingController();
    _tcPass = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tcMail.dispose();
    _tcPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scWidth = MediaQuery.of(context).size.width;
    _scHeight = MediaQuery.of(context).size.height;
    if (MediaQuery.of(context).size.aspectRatio > 1) {
      _scWidth = MediaQuery.of(context).size.width / 3;
    }
    // debugPrint(
    //     "Aspect Ratio: ${MediaQuery.of(context).size.aspectRatio} - Width:  ${MediaQuery.of(context).size.width} - Height:  ${MediaQuery.of(context).size.height}");
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: (MediaQuery.of(context).size.width < 505 &&
                        MediaQuery.of(context).size.height < 600)
                    ? MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height
                    : 3 / 4,
                child: CustomScrollView(
                  primary: false,
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/app_icon.png",
                              width: _scWidth / 3,
                              height: _scWidth / 3,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: TextField(
                                controller: _tcMail,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  hintText: "E-Posta",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                bottom: 32,
                              ),
                              child: TextField(
                                controller: _tcPass,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  hintText: "Şifre",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: _tcMail.text.trim(),
                                    password: _tcPass.text.trim(),
                                  )
                                      .catchError((e, s) async {
                                    debugPrint("error: ${e.toString()}");
                                    setState(() {
                                      _isLoading = false;
                                    });

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Hata"),
                                            content: Text(
                                                "Hata Detayı: \"${e.toString()}\""),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Tamam"),
                                              )
                                            ],
                                          );
                                        });
                                  }).then((value) {
                                    debugPrint("Giriş yapıldı: $value");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePageUI()));
                                  });
                                },
                                child: Text(
                                  "Giriş Yap",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: AppColors.darkGrey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //       FirebaseAuth.instance
                            //           .createUserWithEmailAndPassword(
                            //         email: _tcMail.text.trim(),
                            //         password: _tcPass.text.trim(),
                            //       )
                            //           .then((value) {
                            //         debugPrint(value.toString());
                            //       });
                            //     },
                            //     child: Text("Kaydol"),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _isLoading ? loadingIndicator() : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

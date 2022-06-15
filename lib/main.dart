import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prompter_app_panel/pages/home_page.dart';
import 'package:prompter_app_panel/pages/login_page.dart';

import 'components/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBTpryodWHYn1BWpxN8svfRjvvn6JBbkVA", // Your apiKey
      appId: "1:807835445772:web:51f979fa500167de7d1c29", // Your appId
      messagingSenderId: "807835445772", // Your messagingSenderId
      projectId: "prompterapp-2e877", // Your projectId
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prompter App Panel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.darkGrey,
        ),
      ),
      home: LoginPageUI(),
    );
  }
}

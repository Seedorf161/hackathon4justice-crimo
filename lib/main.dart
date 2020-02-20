import 'package:crimo/misc/color.dart';
import 'package:crimo/pages/account/loginPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crimo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Lato",
        primarySwatch: MyColors.primaryColor,
      ),
      home: LoginPage(),
    );
  }
}

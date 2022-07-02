import 'package:assingment_2/screen/widgets/constants.dart';
import 'package:assingment_2/screen/loginPage.dart';
import 'package:flutter/material.dart';
import 'app/dependencies.dart' as di;

void main() async {
  di.init();
  runApp(
    MaterialApp(
      title: 'JAFU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.blue,
        dividerColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialRoute: '/',
      home: LoginPage(),
    ),
  );
}

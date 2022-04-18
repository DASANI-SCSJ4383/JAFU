import 'package:flutter/material.dart';
import 'package:jafu/screens/facerecognition/menu.dart';
import 'package:jafu/screens/homePage/home_page.dart';
import 'package:jafu/screens/initialpage/initial.dart';
import 'package:jafu/screens/loginPage/login_page.dart';
import 'package:jafu/screens/phoneAuth/otp.dart';
import 'package:jafu/screens/phoneAuth/phone_auth.dart';
import 'package:jafu/screens/registerPage/register_page.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {

    case '/':
    case '/initial':
      return Initial.route();

    case '/login':
      return LoginPage.route();

    case '/homepage':
      return Homepage.route();

    case '/phoneAuth':
      return PhoneAuth.route();

    case '/otp':
      return Otp.route(phoneNumber: settings.arguments as String);

    case '/register':
      return RegisterPage.route(phoneNumber: settings.arguments[0],viewmodel: settings.arguments[1],);

    case '/facerecognition':
      return Menu.route();

  }
  return null;
}
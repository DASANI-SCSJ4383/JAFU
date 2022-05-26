import 'package:flutter/material.dart';
import 'package:jafu/screens/createGroupPage/create_group_page.dart';
import 'package:jafu/screens/facerecognition/menu.dart';
import 'package:jafu/screens/groupPage/add_post.dart';
import 'package:jafu/screens/groupPage/cart_page.dart';
import 'package:jafu/screens/groupPage/group_info_page.dart';
import 'package:jafu/screens/groupPage/review_post.dart';
import 'package:jafu/screens/initialpage/initial.dart';
import 'package:jafu/screens/loginPage/login_page.dart';
import 'package:jafu/screens/phoneAuth/otp.dart';
import 'package:jafu/screens/phoneAuth/phone_auth.dart';
import 'package:jafu/screens/registerPage/register_page.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

import '../screens/chatPage/channelListPage.dart';
import '../screens/groupPage/in_group_page.dart';
import '../screens/searchPage/search_page.dart';
import '../screens/searchResultpage/search_result_page.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {

    // case '/':
    case '/initial':
      return Initial.route();

    case '/login':
      return LoginPage.route();

    case '/':
    // case '/homepage':
    //   return Homepage.route(userviewmodel: settings.arguments as UserViewmodel);

    case '/phoneAuth':
      return PhoneAuth.route();

    case '/otp':
      return Otp.route(phoneNumber: settings.arguments as String);

    case '/register':
      return RegisterPage.route(phoneNumber: settings.arguments[0],viewmodel: settings.arguments[1],);

    case '/facerecognition':
      return Menu.route(userviewmodel: settings.arguments as UserViewmodel);
    
    case '/createGroup':
      return CreateGroupPage.route(userviewmodel: settings.arguments as UserViewmodel);

    case '/groupInfo':
      return GroupInfoPage.route(groupViewmodel: settings.arguments[0],userViewmodel: settings.arguments[1],index: settings.arguments[2]);

    case '/search':
      return Search.route(
          viewmodel: settings.arguments[0], search: settings.arguments[1]);

    case '/resultsearch':
      return SearchResult.route(searchViewmodel: settings.arguments[0],userViewmodel: settings.arguments[1], search: settings.arguments[2]);

    case '/inGroup':
      return InGroupPage.route(
          userViewmodel: settings.arguments[0], groupViewmodel: settings.arguments[1],index: settings.arguments[2]);

    case '/cartPage':
      return CartPage.route(
          userViewmodel: settings.arguments[0], groupViewmodel: settings.arguments[1],index: settings.arguments[2]);
    
    case '/addPost':
      return AddPost.route(userviewmodel: settings.arguments[0],groupViewmodel: settings.arguments[1],index: settings.arguments[2]);

    case '/chat':
      return ChannelListPage.route();

    case '/reviewPost':
      return ReviewPost.route(
          userviewmodel: settings.arguments[0], post: settings.arguments[1],imageList: settings.arguments[2]);

  }
  return null;
}

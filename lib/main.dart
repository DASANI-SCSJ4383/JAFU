import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jafu/models/user.dart';
import 'package:jafu/screens/chatPage/app.dart';
import 'package:jafu/screens/homePage/home_page.dart';
import 'package:jafu/services/provider/google_sign_in.dart';
import 'package:jafu/services/provider/phone_sign_in.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart' as chat;
import 'app/dependencies.dart' as di;
import 'app/router.dart';
import 'screens/widgets/constants.dart';

void main() async{
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  final client = chat.StreamChatClient(streamKey);
  await Firebase.initializeApp();
  UserViewmodel _userviewmodel = UserViewmodel();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var username = preferences.getString('user');
  if(username!=null){
    Map json = await jsonDecode(username);
    var user = User.fromJson(json);
    _userviewmodel.user = user;
  }
  username!=null?
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => PhoneSignInProvider())
      ],
      child: MaterialApp(
        title: 'JAFU',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primarySwatch: Colors.blue,
          dividerColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // initialRoute: '/',
        builder: (context, child) {
          return chat.StreamChat(
          streamChatThemeData: chat.StreamChatThemeData(
            otherMessageTheme: chat.MessageThemeData(
              messageTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,
              )
            ),
            ownMessageTheme: chat.MessageThemeData(
              messageTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,
              ),
              avatarTheme: chat.AvatarThemeData(
                constraints: BoxConstraints(maxWidth: 80, maxHeight: 80),
                borderRadius: BorderRadius.circular(120),
              )
            )
            ),
            client: client, 
            child: chat.ChannelsBloc(
              child: chat.UsersBloc(
                child: child,
              ),
            )
          );
        },
        home: Homepage(_userviewmodel),
        onGenerateRoute: createRoute,
      ),
    )
  ):runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => PhoneSignInProvider())
      ],
      child: MaterialApp(
        title: 'JAFU',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, child) {
          return chat.StreamChat(
          streamChatThemeData: chat.StreamChatThemeData(
            otherMessageTheme: chat.MessageThemeData(
              messageTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,
              )
            ),
            ownMessageTheme: chat.MessageThemeData(
              messageTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20,
              ),
              avatarTheme: chat.AvatarThemeData(
                constraints: BoxConstraints(maxWidth: 80, maxHeight: 80),
                borderRadius: BorderRadius.circular(120),
              )
            )
            ),
            client: client, 
            child: chat.ChannelsBloc(
              child: chat.UsersBloc(
                child: child,
              ),
            )
          );
        },
        initialRoute: '/login',
        onGenerateRoute: createRoute,
      ),
    )
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jafu/services/provider/google_sign_in.dart';
import 'package:jafu/services/provider/phone_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/dependencies.dart' as di;
import 'app/router.dart';
import 'screens/widgets/constants.dart';

void main() async{
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var username = preferences.getString('user');
  username!=null?
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (context) => PhoneSignInProvider())
      ],
      child: MaterialApp(
        title: 'MVVM Template',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
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
        title: 'MVVM Template',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/login',
        onGenerateRoute: createRoute,
      ),
    )
  );
}

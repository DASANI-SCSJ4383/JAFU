import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jafu/models/user.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/screens/widgets/my_text_button.dart';
import 'package:jafu/viewmodel/login_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {

  static Route route() =>
        MaterialPageRoute(builder: (context) => LoginPage());

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<LoginPage> {
  DateTime prebackpress = DateTime.now();
  bool isPasswordVisible = true;
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNum = TextEditingController();
  bool _visibility1 = true;
  FirebaseMessaging _messaging;
  String _token;
  LoginViewmodel _viewmodel = LoginViewmodel();

  getToken() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    _messaging.getToken().then((token) {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            final timegap = DateTime.now().difference(prebackpress);
            final cantExit = timegap >= Duration(seconds: 2);
            prebackpress = DateTime.now();
            if (cantExit) {
              final snack = SnackBar(
                content: Text('Press Back button again to Exit'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return false;
            } else {
              SystemNavigator.pop();
              return true;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kBackgroundColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              // leading: IconButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: Image(
              //     width: 24,
              //     color: Colors.white,
              //     image: Svg('assets/images/back_arrow.svg'),
              //   ),
              // ),
            ),
            body: CustomScrollView(
              reverse: true,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 5,
                            child: Image.asset(
                              'assets/images/jafu.png',
                              height: 20.h,
                              width: 50.w,
                            ),
                          ),
                          Flexible(
                            // fit: FlexFit.loose,
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                // TextFormField(
                                //   controller: username,
                                //   style: kBodyText.copyWith(color: Colors.white,fontSize: 25),
                                //   decoration: InputDecoration(
                                //     hintText: "Username",
                                //     hintStyle: kBodyText,
                                //     fillColor: Colors.white,
                                //     focusedBorder: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(25.0),
                                //       borderSide: BorderSide(
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //         color: Colors.grey,
                                //         width: 1,
                                //       ),
                                //       borderRadius: BorderRadius.circular(18),
                                //     ),
                                //   ),
                                //   onChanged: (text) => setState(() => username.text),
                                // ),
                                TextFormField(
                                  controller: phoneNum,
                                  style: kBodyText.copyWith(color: Colors.white,fontSize: 25),
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text('+60', style: kBodyText.copyWith(color: Colors.white))),
                                    hintText: "Phone Number",
                                    hintStyle: kBodyText,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onChanged: (text) => setState(() => phoneNum.text),
                                  keyboardType:
                                      TextInputType.numberWithOptions(decimal: false),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: password,
                                  obscureText: _visibility1,
                                  style: kBodyText.copyWith(color: Colors.white,fontSize: 25),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(_visibility1 == true? Icons.visibility : Icons.visibility_off, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          _visibility1 = !_visibility1;
                                        });
                                      },
                                    ),
                                    hintText: "Password",
                                    hintStyle: kBodyText,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onChanged: (text) => setState(() => password.text),
                                ),
                              ],
                            ),
                          ),
                          MyTextButton(
                            buttonName: 'Sign In',
                            onTap: ()async {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.loading
                              );
                              String fullNoTel = "+60" + phoneNum.text;
                              User a = await _viewmodel.authenticate(fullNoTel,password.text);
                              if(a == null){
                                Navigator.pop(context);
                              }else{
                                UserViewmodel _userviewmodel = UserViewmodel();
                                _userviewmodel.user = a;
                                // await _viewmodel.updateUserToken(getToken());
                                Navigator.pop(context);
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences.setString('user', jsonEncode(a));
                                print(a.username);
                                Navigator.popAndPushNamed(context, '/homepage',arguments: _userviewmodel);
                              }
                            },
                            bgColor: Colors.white,
                            textColor: Colors.black87,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Dont't have an account? ",
                                style: kBodyText,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/phoneAuth');
                                },
                                child: Text(
                                  'Register',
                                  style: kBodyText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

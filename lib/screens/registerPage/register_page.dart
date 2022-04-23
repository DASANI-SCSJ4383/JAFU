import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/screens/widgets/my_text_button.dart';
import 'package:jafu/viewmodel/reg_viewmodel.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterPage extends StatefulWidget {

  static Route route({phoneNumber,viewmodel}) =>
      MaterialPageRoute(builder: (context) => RegisterPage(phoneNumber: phoneNumber,viewmodel: viewmodel));

  final String _phoneNum;
  final RegisterViewModel _viewmodel;

  const RegisterPage({phoneNumber,viewmodel}) : _phoneNum = phoneNumber,_viewmodel=viewmodel;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  bool _visibility1 = true;
  bool _visibility2 = true;

  String errorPassword(TextEditingController a) {
    final text = a.value.text;
    if (text.isNotEmpty) {
      if (text.length < 6) {
        return 'Kata laluan mestilah melebihi 5 perkataan';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: kBackgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "ALERT",
                  desc: "Are you sure you want to cancel this process?",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        username.clear();
                        password.clear();
                        confirmpassword.clear();
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(context, '/login');
                      },
                      width: 120,
                    ),
                    DialogButton(
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 120,
                    )
                  ],
                ).show();
              },
              icon: Image(
                width: 24,
                color: Colors.white,
                image: Svg('assets/images/back_arrow.svg'),
              ),
            ),
          ),
          body: CustomScrollView(
            reverse: false,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Flexible(
                        //   flex: 5,
                        //   child: Image.asset(
                        //     'assets/images/jafu.png',
                        //     height: 20.h,
                        //     width: 50.w,
                        //   ),
                        // ),
                        Flexible(
                          // fit: FlexFit.loose,
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                          "Register",
                          style: kHeadline,
                        ),
                        Text(
                          "Create new account to get started.",
                          style: kBodyText2,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                              TextFormField(
                                controller: username,
                                style: kBodyText.copyWith(color: Colors.white,fontSize: 25),
                                decoration: InputDecoration(
                                  hintText: "Username",
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
                                onChanged: (text) => setState(() => confirmpassword.text),
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
                                  errorText: errorPassword(password),
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
                                onChanged: (text) => setState(() => confirmpassword.text),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: confirmpassword,
                                obscureText: _visibility2,
                                style: kBodyText.copyWith(color: Colors.white,fontSize: 25),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(_visibility2 == true? Icons.visibility : Icons.visibility_off, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        _visibility2 = !_visibility2;
                                      });
                                    },
                                  ),
                                  hintText: "Confirm Password",
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
                                onChanged: (text) => setState(() => confirmpassword.text),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              MyTextButton(
                                buttonName: 'Sign Up',
                                onTap: ()async{
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if(username.text.isEmpty || password.text.isEmpty || confirmpassword.text.isEmpty ){
                                    final SnackBar snackBar = SnackBar(content: Text("Please fill in all the field to proceed."),
                                                                duration: Duration(seconds: 1, milliseconds: 500),
                                                              );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  else if(password.text != confirmpassword.text){
                                    final SnackBar snackBar = SnackBar(content: Text("The password is not matched with the confirm password."),
                                                                duration: Duration(seconds: 1, milliseconds: 500),
                                                              );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                  else{
                                    String result = await widget._viewmodel.register(username.text,password.text,widget._phoneNum);
                                    if(result == "success"){
                                      Alert(
                                        onWillPopActive: true,
                                        context: context,
                                        type: AlertType.success,
                                        title: "SUCCESS",
                                        desc: "Your registration was successful.",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                            onPressed: (){
                                              username.clear();
                                              password.clear();
                                              confirmpassword.clear();
                                              Navigator.popAndPushNamed(context, '/login');
                                            },
                                            width: 120,
                                          )
                                        ],
                                      ).show();
                                    }else{
                                      Alert(
                                        onWillPopActive: true,
                                        context: context,
                                        type: AlertType.error,
                                        title: "ERROR",
                                        desc: "Something went wrong. Please try again.",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "OK",
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                            onPressed: (){
                                              username.clear();
                                              password.clear();
                                              confirmpassword.clear();
                                              Navigator.popAndPushNamed(context, '/login');
                                            },
                                            width: 120,
                                          )
                                        ],
                                      ).show();
                                    }
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
                                    "Already have an account? ",
                                    style: kBodyText,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: kBodyText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/screens/widgets/my_text_button.dart';
import 'package:jafu/screens/widgets/my_password_field.dart';
import 'package:jafu/screens/widgets/my_text_field.dart';
import 'package:jafu/viewmodel/reg_viewmodel.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {

  static Route route() =>
        MaterialPageRoute(builder: (context) => LoginPage());

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<LoginPage> {
  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => SafeArea(
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
          body: SafeArea(
            //to make page scrollable
            child: CustomScrollView(
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
                                MyTextField(
                                  hintText: 'Phone, email or username',
                                  inputType: TextInputType.text,
                                ),
                                MyPasswordField(
                                  isPasswordVisible: isPasswordVisible,
                                  onTap: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          MyTextButton(
                            buttonName: 'Sign In',
                            onTap: () {},
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

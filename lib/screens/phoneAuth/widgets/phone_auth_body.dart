import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/viewmodel/reg_viewmodel.dart';
import 'package:retry/retry.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool icon = true;
  final phoneNum = TextEditingController();

  Future<String> checkPhoneNumber(String phoneNum, String type) async {
    var encodedNoTel = Uri.encodeComponent (phoneNum);
    try{
      final r = RetryOptions(maxAttempts: 6);
      var url = "http://159.223.63.41/phoneApi/checkInputAvailability/" + encodedNoTel + "/" + type;
      var result = await r.retry(() => http.get(Uri.parse(url)));
      String response = result.body;
      if (result == null || response == "invalid") return null;
      return response;
    }catch(e){
      return "Network Problem";
    }  
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Center(
          child: Column(
            children: [
              Flexible(
                flex: 5,
                child: Image.asset(
                  'assets/images/jafu.png',
                  height: 50.h,
                  width: 50.w,
                ),
              ),
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.sp),
                      child: TextFormField(
                        controller: phoneNum,
                        style: kBodyText.copyWith(color: Colors.white),
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
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    SizedBox(
                      height: 30.sp,
                      width: 60.sp,
                    ),
                    InkWell(
                      onTap: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        if(phoneNum.text == ""){
                          Alert(
                            onWillPopActive: true,
                            context: context,
                            type: AlertType.warning,
                            title: "ALERT",
                            desc: "Please input your phone number.",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                width: 120,
                              )
                            ],
                          ).show();
                        }else{
                          String fullNoTel = "+60" + phoneNum.text;
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading
                          );
                          String a = await checkPhoneNumber(fullNoTel,"noTel");
                          if(a == "Network Problem"){
                            Navigator.pop(context);
                            Alert(
                              context: context,
                              type: AlertType.error,
                              title: "NETWORK PROBLEM",
                              desc: "Please check your internet connection.",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          }else if(a == "valid"){
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/otp',arguments: fullNoTel);
                            // RegisterViewModel registerViewModel = RegisterViewModel();
                            // Navigator.pushNamed(context, '/register',arguments: [fullNoTel,registerViewModel]);
                            phoneNum.clear();
                          }else{
                            Navigator.pop(context);
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "INVALID",
                              desc: "This number has been registered.",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                )
                              ],
                            ).show();
                          } 
                        }
                      },
                      child: Text(
                        'Hantar',
                        style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

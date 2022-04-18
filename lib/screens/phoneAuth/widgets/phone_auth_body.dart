import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jafu/screens/widgets/constants.dart';
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
    var url = "http://10.211.101.169/jafu/phoneApi/checkInputAvailability/" + phoneNum + "/" + type;
    var result = await http.get(Uri.parse(url));
    String response = result.body;
    if (result == null || response == "invalid") return null;
    return response;
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
                        String fullNoTel = "+60" + phoneNum.text;

                        BuildContext dialogContext;
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            dialogContext = context;
                            return Dialog(
                              child:  Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                    CircularProgressIndicator(),
                                    Text("Sila Tunggu"),
                                ],
                              ),
                            );
                          },
                        );
                        
                        String a = await checkPhoneNumber(fullNoTel,"noTel");
                        if(a == "valid"){
                          Navigator.pop(dialogContext);
                          Navigator.pushNamed(context, '/otp',arguments: fullNoTel);
                          // Navigator.pushNamed(context, '/register',arguments: fullNoTel);
                          phoneNum.clear();
                        }else{
                          Navigator.pop(dialogContext);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title:  Text("PERHATIAN"),
                                content:  Text("Harap maaf, nombor telefon ini telah didaftarkan"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  TextButton(
                                    child:  Text("Tutup"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                          );
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

import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/screens/widgets/constants.dart';
import 'package:jafu/screens/phoneAuth/widgets/phone_auth_body.dart';
import 'package:sizer/sizer.dart';

class PhoneAuth extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => PhoneAuth());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Sizer(builder: (context, orientation, deviceType) {
            return Scaffold(
                backgroundColor: kBackgroundColor, 
                appBar: AppBar(
                  backgroundColor: kBackgroundColor,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image(
                      width: 24,
                      color: Colors.white,
                      image: Svg('assets/images/back_arrow.svg'),
                    ),
                  ),
                ),
                body: Body()
            );
          }),
        ],
      ),
    );
  }
}

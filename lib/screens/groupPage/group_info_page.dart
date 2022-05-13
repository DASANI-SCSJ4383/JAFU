import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/screens/widgets/constants.dart';

class GroupInfoPage extends StatelessWidget {

  static Route route() =>
        MaterialPageRoute(builder: (context) => GroupInfoPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          Center(
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 4,color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1)
                  )
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://cdn.pixabay.com/photo/2017/11/27/21/31/computer-2982270_960_720.jpg"
                  )
                )
              ),
            ),
          ),
          SizedBox(height: 24,),
          Column(
            children:const [
              Text("Test",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24)),
              SizedBox(height: 4),
              Text("Test",style: TextStyle(color: Colors.grey)), 
            ],
          ),
          SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: (){
          
              },
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              child: Text("JOIN")
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){
            
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text("Test",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                        SizedBox(height: 2),
                        Text("Test",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    onPressed: (){
            
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text("Test",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                        SizedBox(height: 2),
                        Text("Test",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 48),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:const [
                Text("About",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24)),
                SizedBox(height: 16),
                Text("About",style: TextStyle(color: Colors.white,fontSize: 16,height: 1.4)),
              ],
            ),
          )
        ],
      )
    );
  }
}

Widget buildImage(){
  final image = NetworkImage("https://picsum.photos/250?image=9");
  return ClipOval(
    child: Ink.image(
      image: image,
      fit: BoxFit.cover,
      width: 128,
      height: 128,
    ),
  );
}
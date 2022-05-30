import 'package:flutter/material.dart';

class Test extends StatefulWidget {

  static Route route() => MaterialPageRoute(
      builder: (context) => Test());

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ASD"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      color: Colors.red,
                      child: Text("TETsdsa"),
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
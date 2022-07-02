import 'package:assingment_2/screen/groupPost.dart';
import 'package:assingment_2/screen/homePage.dart';
import 'package:assingment_2/screen/myPost.dart';
import 'package:flutter/material.dart';

import '../viewmodel/user_viewmodel.dart';

class InGroupPage extends StatefulWidget {
  UserViewmodel _userviewmodel = UserViewmodel();

  InGroupPage(UserViewmodel _viewmodel) : _userviewmodel = _viewmodel;

  @override
  State<InGroupPage> createState() => _InGroupPageState();
}

class _InGroupPageState extends State<InGroupPage>
    with SingleTickerProviderStateMixin {
  bool isReadmore = false;
  int activeIndex = 0;

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff191720),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Homepage(widget._userviewmodel)),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.newspaper)),
              Tab(icon: Icon(Icons.my_library_add)),
            ],
          ),
          title: Text("Test"),
          // title: Text(Provider.of<UserProvider>(context).userID),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            WillPopScope(
                onWillPop: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Homepage(widget._userviewmodel)),
                  );
                  return true;
                },
                child: GroupPost()),
            WillPopScope(
                onWillPop: () async {
                  _tabController?.index = 0;
                  return false;
                },
                child: MyPost(widget._userviewmodel)),
          ],
        ),
      ),
    );
  }
}

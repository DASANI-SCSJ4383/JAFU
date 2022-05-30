import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:jafu/screens/groupPage/group_tab_bar1.dart';
import 'package:jafu/screens/groupPage/group_tab_bar2.dart';
import 'package:jafu/screens/groupPage/group_tab_bar3.dart';
import 'package:jafu/screens/groupPage/group_tab_bar4.dart';
import 'package:sizer/sizer.dart';

import '../../viewmodel/group_viewmodel.dart';
import '../../viewmodel/user_viewmodel.dart';
import '../homePage/home_page.dart';

class InGroupPage extends StatefulWidget {

  static Route route({userViewmodel, groupViewmodel, index}) => MaterialPageRoute(
      builder: (context) =>
          InGroupPage(userViewmodel: userViewmodel, groupViewmodel: groupViewmodel, index: index));

  final UserViewmodel _userViewmodel;
  final GroupViewmodel _groupViewmodel;
  final int _index;

  const InGroupPage({userViewmodel, groupViewmodel, index})
      : _userViewmodel = userViewmodel,
        _groupViewmodel = groupViewmodel,
        _index = index;

  @override
  State<InGroupPage> createState() => _InGroupPageState();
}

class _InGroupPageState extends State<InGroupPage> with SingleTickerProviderStateMixin {

  bool isReadmore = false;
  int activeIndex = 0;

  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0)..addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff191720),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Homepage(widget._userViewmodel)),
                );
              },
              icon: Image(
                width: 24,
                color: Colors.white,
                image: Svg('assets/images/back_arrow.svg'),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.newspaper)),
                Tab(icon: Icon(Icons.my_library_add)),
                Tab(icon: Icon(Icons.shopping_cart)),
                Tab(icon: Icon(Icons.info)),
              ],
            ),
            title: Text(widget._groupViewmodel.group[widget._index].groupName),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              WillPopScope(
                onWillPop: ()async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Homepage(widget._userViewmodel)),
                  );
                  return true;
                },
                child: GroupTabBar1(widget._userViewmodel,widget._groupViewmodel,widget._index)
              ),
              WillPopScope(
                onWillPop: ()async{
                  _tabController.index = 0;
                  return false;
                },
                child: GroupTabBar2(widget._userViewmodel,widget._groupViewmodel,widget._index)
              ),
              WillPopScope(
                onWillPop: ()async{
                  _tabController.index = 0;
                  return false;
                },
                child: GroupTabBar3(widget._userViewmodel,widget._groupViewmodel,widget._index)
              ),
              WillPopScope(
                onWillPop: ()async{
                  _tabController.index = 0;
                  return false;
                },
                child: GroupTabBar4()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
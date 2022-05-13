import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/group_viewmodel.dart';
import 'package:jafu/viewmodel/search_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class Content extends StatefulWidget {

  @override
    _ContentState createState() => _ContentState();
    final SearchViewmodel _viewmodel;
    final UserViewmodel _userViewmodel;
    final _search;
    const Content(SearchViewmodel viewmodel,UserViewmodel userViewmodel, String search)
        : _viewmodel = viewmodel,
          _userViewmodel = userViewmodel,
          _search = search;
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 35.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.popAndPushNamed(context, '/search', arguments: [widget._userViewmodel, null]);
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.grey,
                margin: EdgeInsets.all(1),
                elevation: 0,
                child: Row(
                  children: const[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            // TextField(
            //   cursorColor: Colors.white,
            //   style: TextStyle(color: Colors.white),
            //   decoration: InputDecoration(
            //       prefixIcon: Icon(Icons.search, color: Colors.white),
            //       hintText: "Search",
            //       contentPadding: EdgeInsets.only(left: 34.0),
            //       filled: true,
            //       fillColor: Colors.grey[800],
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(50.0),
            //         borderSide: BorderSide.none,
            //       )),
            // ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            //Now we will build the chat feed listview
            widget._viewmodel.searchItems.length != 0?
            Expanded(
              child: ListView.builder(
                itemCount: widget._viewmodel.searchItems.length,
                itemBuilder: (context, index) => listItem("https://images.unsplash.com/photo-1573890990305-0ab6a7195ab6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80", 
                widget._viewmodel.searchItems[index].groupName, String, "Wassup", "9:53PM",index),
              ) 
            ):Center(
              child: Text("No result found",style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget avatarWidget(String urlImg, double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            image: NetworkImage(urlImg),
          )),
    );
  }

  Widget listItem(
      String urlImg, String userName, String, message, String hour,int _index) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   page = 2;
        //   bodyWidget = secondBody();
        // });
        GroupViewmodel _groupViewmodel = GroupViewmodel();
        _groupViewmodel.searchGroup = widget._viewmodel.searchItems;
        Navigator.pushNamed(context, "/groupInfo",arguments: [_groupViewmodel,widget._userViewmodel,_index]);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Container(
          child: Row(
            children: [
              avatarWidget(urlImg, 60.0),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                hour,
                style: TextStyle(
                  color: Colors.grey[50],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
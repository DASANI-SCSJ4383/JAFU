import 'package:flutter/material.dart';
import 'package:jafu/viewmodel/search_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:sizer/sizer.dart';

class SearchBody extends StatefulWidget {

  final UserViewmodel _viewmodel;
  final _search;
  const SearchBody(UserViewmodel viewmodel, String search)
      : _viewmodel = viewmodel,
        _search = search;

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final SearchViewmodel _searchViewmodel = SearchViewmodel();
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xff191720),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Card(
            color: Colors.grey,
            margin: EdgeInsets.only(
              top: 25,
              bottom: 25,
            ),
            elevation: 0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(.0),
                  child: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                    child: widget._search == null
                        ? TextField(
                            autofocus: true,
                            controller: search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) async {
                              await _searchViewmodel.search(value);
                              Navigator.popAndPushNamed(context, '/resultsearch',
                                  arguments: [_searchViewmodel,widget._viewmodel, value]);
                            },
                          )
                        : TextFormField(
                            autofocus: true,
                            initialValue: widget._search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (value) async {
                              await _searchViewmodel.search(value);
                              Navigator.popAndPushNamed(context, '/resultsearch',
                                  arguments: [_searchViewmodel,widget._viewmodel, value]);
                            },
                        )),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:const [
                        Expanded(
                          flex: 1,
                          child: Icon(Icons.history),
                        ),
                        Expanded(flex: 9, child: Text('Group ...')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
      ),
    );
  }
}
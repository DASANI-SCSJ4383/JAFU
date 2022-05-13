import 'package:flutter/material.dart';
import 'package:jafu/screens/searchResultpage/search_result_body.dart';
import 'package:jafu/viewmodel/search_viewmodel.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class SearchResult extends StatelessWidget {
  static Route route({searchViewmodel,userViewmodel, search}) => MaterialPageRoute(
      builder: (context) =>
          SearchResult(searchViewmodel: searchViewmodel,userViewmodel: userViewmodel, search: search));

  final SearchViewmodel _searchViewmodel;
  final UserViewmodel _userViewmodel;
  final String _search;

  const SearchResult({searchViewmodel,userViewmodel, search})
      : _searchViewmodel = searchViewmodel,
      _userViewmodel = userViewmodel,
        _search = search;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Content(_searchViewmodel,_userViewmodel,_search),
    ));
  }
}

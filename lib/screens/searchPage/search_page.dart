import 'package:flutter/material.dart';
import 'package:jafu/screens/searchPage/search_body.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

class Search extends StatelessWidget {
  static Route route({viewmodel, search}) => MaterialPageRoute(
      builder: (context) =>
          Search(viewmodel: viewmodel, search: search));

  final UserViewmodel _viewmodel;
  final String _search;

  const Search({viewmodel, search})
      : _viewmodel = viewmodel,
        _search = search;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SearchBody(_viewmodel,_search),
      ));
  }
}

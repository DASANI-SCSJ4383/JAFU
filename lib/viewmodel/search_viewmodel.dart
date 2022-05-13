import 'package:jafu/app/dependencies.dart';
import 'package:jafu/services/search/search_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class SearchViewmodel extends Viewmodel {

  SearchService get searchService => dependency();

  List _searchItems = [];

  get searchItems => _searchItems;
  set searchItems(value) => _searchItems = value;
  
  Future<void> search(String search) async {
    _searchItems = [];
    _searchItems = await searchService.getSearch(search);
  }

}
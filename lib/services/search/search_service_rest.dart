import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jafu/models/group.dart';
import 'package:jafu/services/search/search_service.dart';

class SearchServiceRest implements SearchService {

  final String _baseUrl;
  const SearchServiceRest({@required baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<List<Group>> getSearch(String search) async {
    var url = _baseUrl + "getSearch/" + search;
    var result = await http.get(Uri.parse(url));
    if (result == null) return null;
    final List listJson = jsonDecode(result.body);
    return listJson.map((json) => Group.fromJson(json)).toList();
  }
}

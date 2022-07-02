import 'dart:convert';
import 'package:assingment_2/services/group/group_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

import '../../model/post.dart';

class GroupServiceRest implements GroupService {
  final String _baseUrl;
  const GroupServiceRest({@required baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<List<Post>> getGroupPost(String groupID) async {
    var url = _baseUrl + "getPost/" + groupID;
    var result = await http.get(Uri.parse(url));
    print(result.body);
    if (result == null) return null;
    final List listJson = jsonDecode(result.body);
    return listJson.map((json) => Post.fromJson(json)).toList();
  }

  @override
  Future<List<Post>> getMyPost(String groupID, String userID) async {
    var url = _baseUrl + "getMyPost/" + groupID + "/" + userID;
    var result = await http.get(Uri.parse(url));
    print(result.body);
    if (result == null) return null;
    final List listJson = jsonDecode(result.body);
    return listJson.map((json) => Post.fromJson(json)).toList();
  }

  // @override
  // Future<String> editPost(Post _post) async {
  //   // var url = "http://localhost:8080/editPost/" +
  //   //     (_post.postID.toString()) +
  //   //     "?title=" +
  //   //     _post.title +
  //   //     "&price=" +
  //   //     _post.price +
  //   //     "&description=" +
  //   //     _post.description;
  //   var url =
  //       "http://localhost:8080/editPost/25?title=t&price=99&description=i";
  //   // var url = _baseUrl + "editPost/" + (_post.postID.toString());
  //   print(url);
  //   final r = RetryOptions(maxAttempts: 6);
  //   try {
  //     var result = await http.put(Uri.parse(url));
  //     String response = result.body;
  //     print("asasfasfasfasfasf");
  //     print(response);
  //     if (response == "false") {
  //       return null;
  //     } else {
  //       return response;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }
  @override
  Future<String> editPost(Post _post) async {
    var url = _baseUrl + "editPost/" + (_post.postID).toString();
    final r = RetryOptions(maxAttempts: 6);
    try {
      print(jsonEncode(<String, String>{
        "title": _post.title,
        "price": _post.price,
        "description": _post.description,
      }));
      var result = await r.retry(() => http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "title": _post.title,
            "price": _post.price,
            "description": _post.description,
          })));
      String response = result.body;
      print(response);
      if (response == "false") {
        return null;
      } else {
        return response;
      }
    } catch (e) {
      return null;
    }
  }
}

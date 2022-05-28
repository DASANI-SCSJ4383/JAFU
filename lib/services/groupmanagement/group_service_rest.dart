import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jafu/models/group.dart';
import 'package:jafu/models/post.dart';
import 'package:jafu/services/groupmanagement/group_service.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class GroupServiceRest implements GroupService {

  final String _baseUrl;
  const GroupServiceRest({@required baseUrl}) : _baseUrl = baseUrl;

  @override
  Future<String> createGroup(String groupName, String groupDescription, String id) async {
    var url = _baseUrl + "/createGroup";
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.post(Uri.parse(url), body: {
        "groupName": groupName,
        "groupDescription": groupDescription,
        "adminID": id,
      }));
      String response = result.body;
      if (result == null || response == "false") return null;
      return response;
    }catch(e){
      return "Network Problem";
    }
    
  }

  @override
  Future<String> joinGroup(String userID, String groupID) async{
    var url = _baseUrl + "/enrollGroup";
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.post(Uri.parse(url), body: {
        "userID": userID,
        "groupID": groupID,
      }));
      String response = result.body;
      print(response);
      if (result == null || response == "false") return null;
      return response;
    }catch(e){
      return "Network Problem";
    }
  }

  @override
  Future<List<Group>> getGroup(String userID) async {

    var url = _baseUrl + "getMyGroup/$userID";
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.get(Uri.parse(url)));
      String response = result.body;
      if (response == "false"){
        return null;
      }else{
        final List listJson = jsonDecode(result.body);
        return listJson.map((json) => Group.fromJson(json)).toList();
      } 
    }catch(e){
      return null;
    }  
  }

  @override
  Future<String> addItem(Post _post,String groupID,String userID) async {
    var url = "http://159.223.63.41/createPost.php";
    var result = await http.post(Uri.parse(url), body: {
      "groupID": groupID,
      "userID": userID,
      "title": _post.postTitle,
      "price": _post.price,
      "description": _post.description,
    });
    String response = result.body;
    return response;
  }

  @override
  Future<List<Post>> getGroupPost(String groupID) async {
    var url = _baseUrl + "getPost/" + groupID;
    var result = await http.get(Uri.parse(url));
    if (result == null) return null;
    final List listJson = jsonDecode(result.body);
    return listJson.map((json) => Post.fromJson(json)).toList();
  }

  @override
  Future<List<Post>> getMyPost(String groupID,String userID) async {
    var url = _baseUrl + "getMyPost/" + groupID + "/" + userID;
    var result = await http.get(Uri.parse(url));
    if (result == null) return null;
    final List listJson = jsonDecode(result.body);
    return listJson.map((json) => Post.fromJson(json)).toList();
  }

}

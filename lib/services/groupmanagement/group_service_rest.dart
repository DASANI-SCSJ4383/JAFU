import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:jafu/services/groupmanagement/group_service.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

import '../../models/cart.dart';
import '../../models/group.dart';
import '../../models/post.dart';

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
      "title": _post.title,
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

  @override
  Future<String> editPost(Post _post) async {

    var url = _baseUrl + "editPost/" + _post.postID;
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.put(Uri.parse(url), body: {
        "title": _post.title,
        "price": _post.price,
        "description": _post.description,
      }));
      String response = result.body;
      if (response == "false"){
        return null;
      }else{
        return response;
      } 
    }catch(e){
      return null;
    }  
  }

  @override
  Future<String> addToCart(String userID, String postID, String groupID) async{
    var url = _baseUrl + "/addToCart";
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.post(Uri.parse(url), body: {
        "userID": userID,
        "postID": postID,
        "groupID": groupID,
      }));
      String response = result.body;
      if (result == null || response == "false") return null;
      return response;
    }catch(e){
      return "Network Problem";
    }
  }

  @override
  Future<List<Cart>> getCart(String groupID,String userID) async {
    var url = _baseUrl + "getCart/$groupID/$userID";
    final r = RetryOptions(maxAttempts: 6);
    try{
      var result = await r.retry(() => http.get(Uri.parse(url)));
      String response = result.body;
      if (response == "false"){
        return null;
      }else{
        final List listJson = jsonDecode(result.body);
        return listJson.map((json) => Cart.fromJson(json)).toList();
      } 
    }catch(e){
      return null;
    }  
  }

}

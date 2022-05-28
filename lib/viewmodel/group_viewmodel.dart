import 'package:jafu/app/dependencies.dart';
import 'package:jafu/services/groupmanagement/group_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

import '../models/post.dart';

class GroupViewmodel extends Viewmodel {

  GroupService get groupService => dependency();

  List _searchGroup = [];
  List _group = [];
  List _post = [];

  get searchGroup => _searchGroup;
  set searchGroup(value) => _searchGroup = value;

  get group => _group;
  set group(value) => _group = value;

  get post => _post;
  set post(value) => _post = value;
  
  Future<String> createGroup(String name,String groupDescription, String id) async {
    String a = await groupService.createGroup(name,groupDescription,id);
    return a;
  }

  Future<String> joinGroup(String userID,String groupID) async {
    String a = await groupService.joinGroup(userID,groupID);
    return a;
  }

  Future<void> getGroup(String userID) async {
    _group = await groupService.getGroup(userID);
  }

  Future<String> createPost(Post _post,String groupID,String userID) async {
    String result = await groupService.addItem(_post,groupID,userID);
    return result;
  }

  Future<void> getGroupPost(String groupID) async {
    List _temp = [];
    _temp = await groupService.getGroupPost(groupID);
    for(int i=0;i<_temp.length;i++){
      _temp[i].picture = _temp[i].pic1;
      if(_temp[i].pic2 != ""){
        _temp[i].picture = _temp[i].pic2;
      }
      if(_temp[i].pic3 != ""){
        _temp[i].picture = _temp[i].pic3;
      }
    }
    _post = _temp;
  }

  Future<void> getMyPost(String groupID,String userID) async {
    List _temp = [];
    _temp = await groupService.getMyPost(groupID,userID);
    for(int i=0;i<_temp.length;i++){
      _temp[i].picture = _temp[i].pic1;
      if(_temp[i].pic2 != ""){
        _temp[i].picture = _temp[i].pic2;
      }
      if(_temp[i].pic3 != ""){
        _temp[i].picture = _temp[i].pic3;
      }
    }
    _post = _temp;
  }

}
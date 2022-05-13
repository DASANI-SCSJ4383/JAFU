import 'package:jafu/app/dependencies.dart';
import 'package:jafu/services/groupmanagement/group_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class GroupViewmodel extends Viewmodel {

  GroupService get groupService => dependency();

  List _searchGroup = [];
  List _group = [];

  get searchGroup => _searchGroup;
  set searchGroup(value) => _searchGroup = value;

  get group => _group;
  set group(value) => _group = value;
  
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

}
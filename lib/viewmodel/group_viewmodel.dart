import 'package:jafu/app/dependencies.dart';
import 'package:jafu/services/groupmanagement/group_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class GroupViewmodel extends Viewmodel {

  GroupService get groupService => dependency();

  List _searchGroup = [];

  get searchGroup => _searchGroup;
  set searchGroup(value) => _searchGroup = value;
  
  Future<String> createGroup(String name,String groupDescription, String id) async {
    String a = await groupService.createGroup(name,groupDescription,id);
    return a;
  }

  Future<String> joinGroup(String userID,String groupID) async {
    String a = await groupService.joinGroup(userID,groupID);
    return a;
  }

}
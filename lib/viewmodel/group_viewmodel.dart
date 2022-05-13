import 'package:jafu/app/dependencies.dart';
import 'package:jafu/services/groupmanagement/group_service.dart';
import 'package:jafu/viewmodel/viewmodel.dart';

class GroupViewmodel extends Viewmodel {

  GroupService get groupService => dependency();
  
  Future<String> createGroup(String name,String groupDescription, String id) async {
    String a = await groupService.createGroup(name,groupDescription,id);
    return a;
  }

}
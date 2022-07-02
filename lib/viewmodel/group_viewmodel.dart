
import '../app/dependencies.dart';
import '../model/post.dart';
import '../services/group/group_service.dart';

class GroupViewmodel{

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

  Future<List<Post>> getGroupPost(String groupID) async {
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
    return _post;
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

  Future<String> editPost(Post _post) async {
    String result = await groupService.editPost(_post);
    return result;
  }
  
}
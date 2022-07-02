

import '../../model/post.dart';

abstract class GroupService {

  Future<List<Post>> getGroupPost(String groupID);
  Future<List<Post>> getMyPost(String groupID,String userID);
  Future<String> editPost(Post _post);
}

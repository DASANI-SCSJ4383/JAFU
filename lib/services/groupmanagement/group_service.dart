
import 'package:jafu/models/post.dart';

import '../../models/group.dart';

abstract class GroupService {

  Future<String> createGroup(String groupName, String groupDescription, String id);
  Future<String> joinGroup(String userID, String groupID);
  Future<List<Group>> getGroup(String userID);
  Future<String> addItem(Post _post);
}

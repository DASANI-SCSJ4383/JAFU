import '../../models/cart.dart';
import '../../models/group.dart';
import '../../models/post.dart';

abstract class GroupService {

  Future<String> createGroup(String groupName, String groupDescription, String id);
  Future<String> joinGroup(String userID, String groupID);
  Future<List<Group>> getGroup(String userID);
  Future<String> addItem(Post _post,String groupID,String userID);
  Future<List<Post>> getGroupPost(String groupID);
  Future<List<Post>> getMyPost(String groupID,String userID);
  Future<String> editPost(Post _post);
  Future<String> addToCart(String userID, String postID, String groupID);
  Future<List<Cart>> getCart(String groupID,String userID);
  
}

import 'package:assingment_2/model/post.dart';
import 'package:flutter/widgets.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _post;

  get post => _post;
  void setPost(List<Post> a) {
    _post = a;
    notifyListeners();
  }
}

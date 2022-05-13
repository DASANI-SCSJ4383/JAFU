

import 'package:jafu/models/group.dart';

abstract class SearchService {
 Future<List<Group>> getSearch(String search);
}
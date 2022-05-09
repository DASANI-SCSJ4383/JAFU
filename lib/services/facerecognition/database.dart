import 'dart:convert';
import 'dart:io';
import 'package:jafu/viewmodel/user_viewmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retry/retry.dart';
import '../../models/user.dart' as user;
import 'package:http/http.dart' as http;

class DataBaseService {
  // singleton boilerplate
  static final DataBaseService _cameraServiceService =
      DataBaseService._internal();

  factory DataBaseService() {
    return _cameraServiceService;
  }
  // singleton boilerplate
  DataBaseService._internal();

  /// file that stores the data on filesystem
  File jsonFile;

  /// Data learned on memory
  Map<String, dynamic> _db = Map<String, dynamic>();
  Map<String, dynamic> get db => this._db;

  Future<void> testing(String a,String userID) async{
    var url = "http://159.223.63.41/phoneApi/try.php";
    var result = await http.post(Uri.parse(url), body:{
      "userID" : userID,
      "faceData" : a
    });
  }

  Future<void> getData(UserViewmodel userViewmodel) async {
    var url = "http://159.223.63.41/phoneApi/facedata/" + userViewmodel.user.userID;
    var result = await http.get(Uri.parse(url));
    if (result.body == 'failed') return null;
    _db = jsonDecode(result.body);
  }

  /// loads a simple json file.
  Future loadDB(UserViewmodel userViewmodel) async {
    getData(userViewmodel);
    // var tempDir = await getApplicationDocumentsDirectory();
    // String _embPath = tempDir.path + '/emb.json';

    // jsonFile = new File(_embPath);

    // if (jsonFile.existsSync()) {
    //   _db = json.decode(jsonFile.readAsStringSync());
    // }
  }

  /// [Name]: name of the new user
  /// [Data]: Face representation for Machine Learning model
  Future saveData(String user, String password, List modelData,UserViewmodel userViewmodel) async {
    String userAndPass = user + ':' + password;
    _db[userAndPass] = modelData;
    String myJson = jsonEncode(_db);
    testing(myJson,userViewmodel.user.userID);
    // jsonFile.writeAsStringSync(json.encode(_db));
  }

  /// deletes the created users
  cleanDB() {
    this._db = Map<String, dynamic>();
    jsonFile.writeAsStringSync(json.encode({}));
  }
}

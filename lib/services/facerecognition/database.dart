import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
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

  Future<void> testing(String a) async{
    var url = "http://10.211.99.139/jafu/try.php";
    var result = await http.post(Uri.parse(url), body:{
      "userID" : "1",
      "faceData" : a
    });
    print(result.body);
  }

  Future<void> getData() async {
    var url = "http://10.211.99.139/jafu/try2.php";
    var result = await http.get(Uri.parse(url));
    if (result == null) return null;
    _db = jsonDecode(result.body);
  }

  /// loads a simple json file.
  Future loadDB() async {
    // getData();
    // var tempDir = await getApplicationDocumentsDirectory();
    // String _embPath = tempDir.path + '/emb.json';

    // jsonFile = new File(_embPath);

    // if (jsonFile.existsSync()) {
    //   _db = json.decode(jsonFile.readAsStringSync());
    // }
  }

  /// [Name]: name of the new user
  /// [Data]: Face representation for Machine Learning model
  Future saveData(String user, String password, List modelData) async {
    String userAndPass = user + ':' + password;
    _db[userAndPass] = modelData;
    String myJson = jsonEncode(_db);
    testing(myJson);
    // jsonFile.writeAsStringSync(json.encode(_db));
  }

  /// deletes the created users
  cleanDB() {
    this._db = Map<String, dynamic>();
    jsonFile.writeAsStringSync(json.encode({}));
  }
}

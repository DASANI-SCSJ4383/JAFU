import 'package:assingment_2/services/group/group_service.dart';
import 'package:assingment_2/services/register/reg_service.dart';
import 'package:get_it/get_it.dart';

import '../services/auth/auth_service.dart';
import '../services/auth/auth_service_rest.dart';
import '../services/group/group_service_rest.dart';
import '../services/register/reg_service_rest.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  String url = "http://10.211.102.249:8080/";

  dependency
      .registerLazySingleton<AuthService>(() => AuthServiceRest(baseUrl: url));

  dependency.registerLazySingleton<GroupService>(
      () => GroupServiceRest(baseUrl: url));
  dependency
      .registerLazySingleton<RegService>(() => RegServiceRest(baseUrl: url));
}

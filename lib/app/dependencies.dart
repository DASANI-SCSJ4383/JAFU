import 'package:get_it/get_it.dart';
import 'package:jafu/services/auth/auth_service.dart';
import 'package:jafu/services/auth/auth_service_rest.dart';
import 'package:jafu/services/groupmanagement/group_service.dart';
import 'package:jafu/services/groupmanagement/group_service_rest.dart';
import 'package:jafu/services/register/reg_service.dart';
import 'package:jafu/services/register/reg_service_rest.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  String url = "http://159.223.63.41/phoneApi/";

  dependency.registerLazySingleton<AuthService>(
    () => AuthServiceRest(baseUrl: url));
  
  dependency.registerLazySingleton<RegService>(
    () => RegServiceRest(baseUrl: url),
  );

  dependency.registerLazySingleton<GroupService>(
    () => GroupServiceRest(baseUrl: url),
  );

  // Viewmodels

  dependency.registerLazySingleton(() => UserViewmodel());
}

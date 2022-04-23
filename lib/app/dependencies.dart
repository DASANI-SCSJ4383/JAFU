import 'package:get_it/get_it.dart';
import 'package:jafu/services/auth/auth_service.dart';
import 'package:jafu/services/auth/auth_service_rest.dart';
import 'package:jafu/services/register/reg_service.dart';
import 'package:jafu/services/register/reg_service_rest.dart';
import 'package:jafu/viewmodel/user_viewmodel.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  String url = "http://10.211.99.125/jafu/phoneApi/";

  dependency.registerLazySingleton<AuthService>(
    () => AuthServiceRest(baseUrl: url));
  
  dependency.registerLazySingleton<RegService>(
    () => RegServiceRest(baseUrl: url),
  );

  // Viewmodels

  dependency.registerLazySingleton(() => UserViewmodel());
}

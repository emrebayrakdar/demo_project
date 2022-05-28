import 'package:demo_project/ui/_products/init/notifier/app_provider_list.dart';
import 'package:demo_project/ui/_products/services/bll/app_service.dart';
import 'package:demo_project/ui/_products/services/bll/authentication_service.dart';
import 'package:demo_project/ui/_products/services/bll/network_manager.dart';
import 'package:demo_project/ui/views/register/repository/auth_repository.dart';
import 'package:demo_project/ui/views/register/repository/local/auth_local_data_source.dart';
import 'package:demo_project/ui/views/register/repository/remote/auth_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'base/init/cache/base_shared_pref_helper.dart';

GetIt locator = GetIt.instance;

Future setUpDI() async {
  //#region #sync

  //#region #provider's
  locator.registerLazySingleton(() => AppProvider());
  //#endregion

  //#region #service's
  locator.registerLazySingleton(() => AppService());
  locator.registerLazySingleton(() => AuthenticationService(null));
  locator.registerLazySingleton(() => NetworkManager());
  //#endregion

  //#region repository's
  locator.registerLazySingleton(() => AuthLocalDataSource());
  locator.registerLazySingleton(() => AuthRemoteDataSource(networkManager: locator()));


  locator.registerLazySingleton(() => AuthRepository(remote: locator(), local: locator()));
  //#endregion

  //#region async
  locator.registerSingleton(await LocaleService.getInstance());
  //#endregion

  //#endregion
}

import 'package:demo_project/base/services/core_dio.dart';
import 'package:demo_project/ui/_products/constants/navigation/api_routes_constants.dart';
import 'package:dio/dio.dart';


class NetworkManager {
  late CoreDio manager;
  late BaseOptions options;

  NetworkManager() {
    options = BaseOptions();
    options.connectTimeout = 15 * 1000;
    options.receiveTimeout = 15 * 1000;
    options.baseUrl = NetworkRoutes.BASE_API_URL;
    // options.headers["API_TOKEN"] = locator<AuthRepository>().getAuthToken();
    // options.headers["Version"] = "";
    // options.headers["LangID"] = "";
    // options.headers["Authorization"] = "Bearer ";
    manager = CoreDio.getInstance(options);
  }

  void setAuthorizationToken(String token) {
    manager.client.options.headers["API_TOKEN"] = token;
  }


}

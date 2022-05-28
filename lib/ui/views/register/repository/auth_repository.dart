import 'package:demo_project/ui/views/register/model/register_response_model.dart';
import 'package:demo_project/ui/views/register/repository/remote/auth_remote_data_source.dart';
import 'package:flutter/cupertino.dart';

import 'local/auth_local_data_source.dart';

class AuthRepository {
  final AuthLocalDataSource local;
  final AuthRemoteDataSource remote;

  AuthRepository({required this.local, required this.remote});
  Future<RegisterResponseModel?> register(BuildContext? context, String userName, String eMail, String password) async => await remote.register(context, userName, eMail, password);

  Future<void> setAuthToken(String token) async => await local.setAuthToken(token);
  String getAuthToken() => local.getAuthToken();

  Future<void> setAuthTokenExpiresDate(String token) async => await local.setAuthTokenExpiresDate(token);
  String getAuthTokenExpiresDate() => local.getAuthTokenExpiresDate();

}

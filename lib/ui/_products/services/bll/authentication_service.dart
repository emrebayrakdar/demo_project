import 'dart:async';
import 'package:demo_project/base/enums/auth_type_enum.dart';
import 'package:demo_project/ui/_products/models/login/login_model.dart';
import 'package:demo_project/ui/views/register/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import '../../../../locator.dart';
import 'app_service.dart';

class AuthenticationService {
  StreamController<UserModel> userController = StreamController<UserModel>();
  final AuthRepository _authRepository = locator<AuthRepository>();
  final AppService _appService = locator<AppService>();

  AuthenticationService(BuildContext? context) {
    initialize(context);
  }

  initialize(BuildContext? context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (await _appService.isRunApi()) {
      if (_authRepository.getAuthToken() != "") {
        ///TODO:Local'e kaydedilen süre ile token süresini karşılaştırıp bitti ise; refresh_token ile yeni token alarak devam edeceğiz. Şuanlık refresh token veya login servisi olmadığı için kontrollerine girmeden direkt logine atalım.
        changeStream(AuthType.Authenticated);
      } else {
        changeStream(AuthType.Unauthenticated);
      }
    } else {
      changeStream(AuthType.Error);
    }
  }

  void changeStream(AuthType _authType, {Map<String, dynamic>? extraData}) {
    var userRow = UserModel.initial();
    userRow.authType = _authType;
    userRow.extraData = extraData;
    userController.add(userRow);
  }

  void setStream(UserModel model) => userController.add(model);

  ///locator<AuthenticationService>().logout();
  void logout() {
    _authRepository.setAuthToken("");
    var userRow = UserModel.initial();
    userRow.authType = AuthType.Unauthenticated;
    userController.add(userRow);
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:demo_project/base/enums/http_request_enum.dart';
import 'package:demo_project/base/init/cache/base_shared_pref_helper.dart';
import 'package:demo_project/base/model/response_model.dart';
import 'package:demo_project/base/services/service_helper.dart';
import 'package:demo_project/ui/_products/constants/navigation/api_routes_constants.dart';
import 'package:demo_project/ui/_products/services/bll/network_manager.dart';
import 'package:demo_project/ui/views/register/model/register_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../locator.dart';

class AuthRemoteDataSource extends ServiceHelper {
  final NetworkManager networkManager;
  LocaleService localeService = locator<LocaleService>();

  AuthRemoteDataSource({required this.networkManager});

  Future<RegisterResponseModel?> register(BuildContext? context, String userName, String eMail, String password) async {
    final response = await networkManager.manager.send<RegisterResponseModel, RegisterResponseModel>(
      NetworkRoutes.REGISTER,
      type: HttpTypes.POST,
      parseModel: RegisterResponseModel(),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      bodyStr: jsonEncode({
         "UserName": userName,
        "Email": eMail,
        "Password": password,
        "TeamName": "Bayrakdar",
        "LanguageCode": "tr",
      }),
    );

    if (response.error != null) showMessage(context, (response.error!.model as RegisterResponseModel?)?.result?.resultMessage ?? response.error?.description);
    return response.data;
  }
}

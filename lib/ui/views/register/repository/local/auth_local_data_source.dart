import 'dart:convert';
import 'package:demo_project/base/init/cache/base_shared_pref_helper.dart';
import 'package:demo_project/ui/_products/constants/enums/shared_preferences_keys.dart';
import 'package:demo_project/ui/_products/services/bll/app_service.dart';
import 'package:flutter/material.dart';

import '../../../../../locator.dart';

class AuthLocalDataSource {
  AppService appService = locator<AppService>();
  final LocaleService _localeService = locator<LocaleService>();

  AuthLocalDataSource();

  ///Encrypt için hive
  Future<void> setAuthToken(String token) async => await _localeService.setStringValue(PreferencesKeys.AUTH_TOKEN.toString(), token);
  String getAuthToken() => _localeService.getStringValue(PreferencesKeys.AUTH_TOKEN.toString());

  Future<void> setAuthTokenExpiresDate(String token) async => await _localeService.setStringValue(PreferencesKeys.AUTH_TOKEN.toString(), token);
  String getAuthTokenExpiresDate() => _localeService.getStringValue(PreferencesKeys.AUTH_TOKEN.toString());

}

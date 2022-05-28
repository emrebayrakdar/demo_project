import 'package:demo_project/base/helpers/toast/toast_helper.dart';
import 'package:demo_project/ui/_products/services/bll/app_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../locator.dart';

abstract class ServiceHelper {
  AppService appService = locator<AppService>();

  void showMessage(BuildContext? context, String? errorStr) {
    if (context == null || errorStr == null) return;
   ToastHelper.error(context, "Hata!", errorStr, alignment: Alignment.bottomCenter,showTime: 5000);
  }
}

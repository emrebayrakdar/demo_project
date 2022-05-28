import 'package:demo_project/base/init/navigation/navigation_service.dart';
import 'package:demo_project/locator.dart';
import 'package:demo_project/ui/_products/models/login/login_model.dart';
import 'package:demo_project/ui/_products/services/bll/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    StreamProvider<UserModel>(initialData: UserModel.initial(), create: (context) => locator<AuthenticationService>().userController.stream),
    Provider.value(value: NavigationService.instance),
  ];
  List<SingleChildWidget> uiChangesItems = [];

  localizedDelegate(List<LocalizationsDelegate> list) {
    return list;
  }
}

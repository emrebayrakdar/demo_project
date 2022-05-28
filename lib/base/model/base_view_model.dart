import 'package:demo_project/base/init/navigation/navigation_service.dart';
import 'package:demo_project/ui/_products/services/bll/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../locator.dart';

abstract class BaseViewModel extends ChangeNotifier {
  late BuildContext context;
  NavigationService navigation = NavigationService.instance;
  AppService appService = locator<AppService>();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  T getParentViewModel<T>(BuildContext context) => Provider.of<T>(context);

  void setContext(BuildContext context) => this.context = context;

  void init(State s);

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}

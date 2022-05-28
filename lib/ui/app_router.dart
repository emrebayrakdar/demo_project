import 'package:demo_project/ui/views/dashboard/view/dashboard_view.dart';
import 'package:demo_project/ui/views/login/view/login_view.dart';
import 'package:demo_project/ui/views/register/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '_products/constants/enums/navigation_constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.LOGIN:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case NavigationConstants.REGISTER:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case NavigationConstants.DASHBOARD:
        return MaterialPageRoute(builder: (_) => const DashboardView());
      default:
        return notFoundPageRoute(settings);
    }
  }

  static MaterialPageRoute notFoundPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('Route belirtilmediği için görüntüleme yapılamıyor! ${settings.name}'),
              ),
            ));
  }
}

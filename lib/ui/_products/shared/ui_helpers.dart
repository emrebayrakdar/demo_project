import 'package:demo_project/base/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class UIHelper {
  static width(double width) => MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!).size.width / 100.0 * width;
  static height(double height)  => MediaQuery.of(NavigationService.instance.navigatorKey.currentContext!).size.height / 100.0 * height;
  static Widget loadingWidget() => const SizedBox(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryColor), height: 20.0, width: 20.0);
}

class FontSizeValue {
  static const double XXXLARGE = 22;
  static const double XXLARGE = 20;
  static const double XLARGE = 18;
  static const double LARGE = 16;
  static const double MEDIUM = 15;
  static const double NORMAL = 14;
  static const double SMALL = 13;
  static const double XSMALL = 11;
  static const double XXSMALL = 9;
}

class SpaceValue {
  static const double NORMAL = 40;
  static const double HIGH = 60;
  static const double MEDIUM = 30;
  static const double LOW = 20;
  static const double VERY_LOW = 15;
  static const double VERY_LOW_HALF = 8;
}

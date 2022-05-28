import 'dart:io';
import 'dart:math';
import 'package:demo_project/base/init/cache/base_shared_pref_helper.dart';
import 'package:demo_project/locator.dart';
import 'package:demo_project/ui/_products/constants/enums/shared_preferences_keys.dart';
import 'package:demo_project/ui/_products/constants/navigation/api_routes_constants.dart';
import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

typedef ItemCreator<S> = S Function();

class AppService {
  final LocaleService _localeService = locator<LocaleService>();

  //#region #methods

  Future<bool> isRunApi() async {
    bool connect = false;
    // return true;
    try {
      final result = await InternetAddress.lookup(NetworkRoutes.BASE_API_URL.replaceAll("https://", "").replaceAll("/", ""));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect = true;
      }
    } on SocketException catch (_) {
      print(_);
      connect = false;
    }
    return connect;
  }

   bool isValidEmail(String value) {
    RegExp regex =
    RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  Future<int> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersionString = packageInfo.version.replaceAll(".", "").toString() + packageInfo.buildNumber.toString();
    int appVersion = int.parse(appVersionString);
    return appVersion;
  }

  bool isFirstTime() {
    if (_localeService.getStringValue(PreferencesKeys.IS_FIRST_LOGIN.toString()) == "") {
      _localeService.setStringValue(PreferencesKeys.IS_FIRST_LOGIN.toString(), "1");
      return true;
    }
    return false;
  }

  void openModalBottomSheet<T>({required BuildContext context, required Widget widget, required double screenHeight}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (bottomCntx) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(bottomCntx).viewInsets.bottom, top: MediaQuery.of(context).padding.top),
            child: Container(color: AppColors.white, height: MediaQuery.of(bottomCntx).size.height * screenHeight, child: widget),
          );
        });
  }


  static String getRandomString(int length) {
    String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await DeviceInfoPlugin().androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await DeviceInfoPlugin().iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
    return deviceData;
  }

  static Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'VersionSdkInt': build.version.sdkInt,
      'VersionRelease': build.version.release,
      'Board': build.board,
      'Brand': build.brand,
      'Device': build.device,
      'Display': build.display,
      'Hardware': build.hardware,
      'Host': build.host,
      'Id': build.id,
      'Manufacturer': build.manufacturer,
      'Model': build.model,
      'Product': build.product,
      'IsPhysicalDevice': build.isPhysicalDevice,
      'AndroidId': build.androidId,
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'Name': data.name,
      'SystemName': data.systemName,
      'SystemVersion': data.systemVersion,
      'Model': data.model,
      'LocalizedModel': data.localizedModel,
      'IdentifierForVendor': data.identifierForVendor,
      'IsPhysicalDevice': data.isPhysicalDevice,
      'UtsNameSysName': data.utsname.sysname,
      'UtsNameNodeName': data.utsname.nodename,
      'UtsNameRelease': data.utsname.release,
      'UtsNameVersion': data.utsname.version,
      'UtsNameMachine': data.utsname.machine,
    };
  }

//#endregion

}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension IntToBool on int {
  bool intToBoolean() {
    if (this == 1) {
      return true;
    } else {
      return false;
    }
  }
}

extension BoolToInt on bool {
  int booleanToInt() {
    if (this == true) {
      return 1;
    } else {
      return 0;
    }
  }
}

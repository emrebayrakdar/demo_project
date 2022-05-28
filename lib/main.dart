import 'dart:async';

import 'package:demo_project/ui/_products/constants/app/app_constants.dart';
import 'package:demo_project/ui/_products/init/notifier/app_provider_list.dart';
import 'package:demo_project/ui/_products/models/login/login_model.dart';
import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:demo_project/ui/views/dashboard/view/dashboard_view.dart';
import 'package:demo_project/ui/views/login/view/login_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:easy_logger/src/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'base/enums/auth_type_enum.dart';
import 'base/init/cache/base_shared_pref_helper.dart';
import 'base/init/navigation/navigation_service.dart';
import 'base/view/global_alert_view.dart';
import 'locator.dart';
import 'ui/app_router.dart';

setUpPrepareApplication() async {
  /* --- Localization Started --- */
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [LevelMessages.error];

  /* --- DI Started --- */
  await setUpDI();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpPrepareApplication();

  runApp(MultiProvider(
      providers: locator<AppProvider>().dependItems,
      child: EasyLocalization(
        startLocale: const Locale('tr', 'TR'),
        saveLocale: true,
        useOnlyLangCode: true,
        supportedLocales: const [Locale('tr', 'TR')],
        path: AppConstants.LANG_ASSET_PATH,
        child: const MyApp(),
      )));
}

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    LocaleService localeService = locator<LocaleService>();
    PackageInfo.fromPlatform().then((PackageInfo value) {
      localeService.setStringValue("version", value.version.toString());
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.setLocale(context.locale);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: AppConstants.APP_TITLE,
      theme: ThemeData.dark(),
      home: Authentication(),
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var getUser = context.watch<UserModel>();
    switch (getUser.authType) {
      case AuthType.Uninitialized: //Henüz Başlatılmadı
        return const Scaffold(body: Center(child: SizedBox(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryColor), height: 20.0, width: 20.0)));
      case AuthType.Authenticated: //Doğrulandı
        return const DashboardView();
      case AuthType.Unauthenticated: //Doğrulanmamış
        return const LoginView();
      case AuthType.Authenticating: //Doğrulanıyor
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthType.Error:
      default:
        return GlobalAlertView(
            isSvg: true, assetsPath: "assets/images/svg/server-error.svg", title: "Hay Aksi!", description: "Sunucu yanıt vermiyor lütfen daha sonra tekrar deneyiniz.");
    }
  }
}

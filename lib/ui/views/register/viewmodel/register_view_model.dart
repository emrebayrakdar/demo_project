import 'package:demo_project/base/helpers/progress_dialog/progress_dialog_helper.dart';
import 'package:demo_project/base/helpers/toast/toast_helper.dart';
import 'package:demo_project/base/init/navigation/navigation_service.dart';
import 'package:demo_project/base/model/base_view_model.dart';
import 'package:demo_project/ui/_products/constants/enums/navigation_constants.dart';
import 'package:demo_project/ui/_products/services/bll/app_service.dart';
import 'package:demo_project/ui/views/register/model/register_response_model.dart';
import 'package:demo_project/ui/views/register/repository/auth_repository.dart';
import 'package:flutter/material.dart';

import '../../../../locator.dart';

class RegisterViewModel extends BaseViewModel {
//#region #init's
  final AuthRepository _authRepository = locator<AuthRepository>();
  final AppService _appService = locator<AppService>();

//#endregion

//#region #variable's
  final formKey = GlobalKey<FormState>();
  late ScrollController scrollController;
  TextEditingController mailTextController = TextEditingController();
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController passwordAgainTextController = TextEditingController();

//#endregion

//#region #override's
  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init(State? s) {
    scrollController = ScrollController(initialScrollOffset: 0);
  }

//#endregion

//#region #methods's

  Future<void> register() async {
    FocusScope.of(context).unfocus();
    //Mail
    if (mailTextController.text == "") {
      ToastHelper.errorSmall(context, "E-mail adresi alanı boş geçilemez. Lütfen tekrar deneyiniz!", showTime: 2000);
    } else if (!_appService.isValidEmail(mailTextController.text)) {
      ToastHelper.errorSmall(context, "E-mail adresiniz hatalı. Lütfen kontrol ediniz!", showTime: 2000);
    }
    //UserName
    else if (userNameTextController.text == "") {
      ToastHelper.errorSmall(context, "Kullanıcı adı alanı boş geçilemez. Lütfen tekrar deneyiniz!", showTime: 2000);
    } else if (passwordTextController.text == "") {
      ToastHelper.errorSmall(context, "Şifre alanı boş geçilemez. Lütfen tekrar deneyiniz!", showTime: 2000);
    } else if (passwordAgainTextController.text == "") {
      ToastHelper.errorSmall(context, "Şifre tekrar alanı boş geçilemez. Lütfen tekrar deneyiniz!", showTime: 2000);
    } else if (passwordTextController.text != passwordAgainTextController.text) {
      ToastHelper.errorSmall(context, "Girilen şifreler uyuşmamakta. Lütfen tekrar deneyiniz!", showTime: 2000);
    } else {
      ///Hazır, kaydedebiliriz.

      ProgressDialogHelper.showLoading(context);
      RegisterResponseModel? loginResp = await _authRepository.register(context, userNameTextController.text, mailTextController.text, passwordTextController.text);
      ProgressDialogHelper.hideLoading(context);
      if (loginResp is RegisterResponseModel) {
        if (loginResp.result != null && loginResp.result!.resultCode == 0) {
          _authRepository.setAuthToken(loginResp.returnObject!.token!);
          ToastHelper.success(context, "Giriş Başarılı", "Yönlendiriliyorsunuz..", showTime: 500);
          await Future.delayed(const Duration(milliseconds: 500));
          NavigationService.instance.navigateToPageClear(path: NavigationConstants.DASHBOARD);
        } else {
          String? errorStr = loginResp.result!.resultMessage;
          ToastHelper.error(context, "Hata!", errorStr ?? "Sunucudan beklenen cevap gelmediği için işleminize devam edilemiyor!");
        }
      }
    }
  }

//#endregion
}

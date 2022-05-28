import 'package:demo_project/base/helpers/progress_dialog/progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialogHelper {
  static void showLoading(BuildContext context, {String? contentText}) async {
    ProgressDialog _progressDialog = ProgressDialog();
    _progressDialog.showProgressDialog(context, textToBeDisplayed: contentText ?? 'Lütfen Bekleyiniz...', onDismiss: () {
      //things to do after dismissing -- optional
    });
  }

  static void hideLoading(BuildContext context) {
    //_progressDialog.dismissProgressDialog(context);
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

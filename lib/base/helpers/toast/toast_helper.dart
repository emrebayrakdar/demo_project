import 'package:demo_project/ui/_products/constants/enums/alert_dialog_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'toast.dart';

class ToastHelper {
  static void success(BuildContext context, String title, String content,{int showTime = 450}) {
    toastAlertDialog(context: context, alignment: Alignment.topRight, dialogType: AlertDialogType.SUCCESS, showTime: showTime, title: title, message: content);
  }

  static void successSmall(BuildContext context, String title) {
    toastAlertDialog(context: context, alignment: Alignment.topRight, dialogType: AlertDialogType.SUCCESS, showTime: 450, title: title, isSmallAlert: true);
  }

  static void error(BuildContext context, String title, String content, {int showTime = 1500, alignment: Alignment.topRight}) {
    toastAlertDialog(context: context, alignment: alignment, dialogType: AlertDialogType.ERROR, showTime: showTime, title: title, message: content);
  }

  static void errorSmall(BuildContext context, String title,{int showTime = 1500}) {
    toastAlertDialog(context: context, alignment: Alignment.topRight, dialogType: AlertDialogType.ERROR, showTime: showTime, title: title, isSmallAlert: true);
  }

  static void warning(BuildContext context, String title, String content, {int showTime = 1500, alignment: Alignment.topRight}) {
    toastAlertDialog(context: context, alignment: alignment, dialogType: AlertDialogType.WARNING, showTime: showTime, title: title, message: content);
  }

  static void warningSmall(BuildContext context, String title,{int showTime = 450}) {
    toastAlertDialog(context: context, alignment: Alignment.topRight, dialogType: AlertDialogType.WARNING, showTime: showTime, title: title, isSmallAlert: true);
  }
}

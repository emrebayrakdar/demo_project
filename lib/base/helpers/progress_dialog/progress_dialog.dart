library progress_dialog;

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:synchronized/synchronized.dart';

class CustomProgressDialog extends StatelessWidget {
  const CustomProgressDialog({
    Key? key,
    this.child,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.shape,
  }) : super(key: key);

  final Widget? child;

  final Duration insetAnimationDuration;

  final Curve insetAnimationCurve;

  final ShapeBorder? shape;

  Color _getColor(BuildContext context) {
    return Theme.of(context).dialogBackgroundColor;
  }

  static const RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)));

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets + const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
        duration: insetAnimationDuration,
        curve: insetAnimationCurve,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Material(
                elevation: 24.0,
                color: _getColor(context),
                type: MaterialType.card,
                child: child,
                shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressDialog {
  bool isDismissed = true;
  var lock = Lock();
  Timer? _timer;

  Future<void> dismissProgressDialog(BuildContext context) async {
    _timer?.cancel();
    await lock.synchronized(() async {
      if (isDismissed) {
        return;
      }
      isDismissed = true;
      // Navigator.of(context, rootNavigator: true).pop(true);
    });
  }

  void showProgressDialog(BuildContext context,
      {Color barrierColor = const Color(0x55222222), required String textToBeDisplayed, Duration dismissAfter = const Duration(seconds: 5), required Function onDismiss}) {
    dismissProgressDialog(context).then((_) {
      isDismissed = false;
      showGeneralDialog(
        context: context,
        barrierColor: barrierColor,
        pageBuilder: (context, animation1, animation2) {
          return CustomProgressDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Container(
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                padding: const EdgeInsets.all(20),
                child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Platform.isIOS ? CupertinoActivityIndicator(radius: 15) : UIHelper.loadingWidget(),
                  Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(textToBeDisplayed, style: TextStyle(color: AppColors.primaryColor, fontSize: FontSizeValue.XSMALL, fontWeight: FontWeight.bold), textAlign: TextAlign.center))
                ])),
          );
        },
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 100),
      ).then((value) {
        bool tmpVal = true;
        if (value == 'false') tmpVal = false;
        isDismissed = tmpVal;
      });
      if (dismissAfter == null) return;
      _timer = Timer(dismissAfter, () {
        dismissProgressDialog(context);
        if (onDismiss != null) onDismiss();
      });
    });
  }
}

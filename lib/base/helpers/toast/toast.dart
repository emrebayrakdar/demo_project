import 'dart:async';
import 'package:demo_project/ui/_products/constants/enums/alert_dialog_constants.dart';
import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void toastAlertDialog(
    {required BuildContext context, required Alignment alignment, required AlertDialogType dialogType, String? title, String? message, int showTime = 3000, bool isSmallAlert = false}) {
  //  showTime parametresi (milisecond) default 3sn
  //  isSmalAlert true ise sadece title parametresini gösterir ve alertin genişliği yazı kadar olur max uzunluga gelınce 2cı satıra geçer.
  TextSpan titleText = TextSpan(
    text: title,
    style: TextStyle(color: dialogType.value.color, fontFamily: "Roboto", fontWeight: FontWeight.bold, fontSize: FontSizeValue.NORMAL, decoration: TextDecoration.none),
  );
  TextSpan messageText = TextSpan(
    text: message,
    style: TextStyle(color: dialogType.value.color, fontFamily: "Roboto", fontWeight: FontWeight.bold, fontSize: FontSizeValue.NORMAL, decoration: TextDecoration.none),
  );

  TextPainter textPainter = TextPainter(
    text: titleText,
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(minWidth: 0, maxWidth: double.infinity);
  final titleSize = textPainter.width;

  textPainter.text = messageText;
  textPainter.layout(minWidth: 0, maxWidth: double.infinity);
  final messageSize = textPainter.width;

  getSize() {
    if (titleSize > messageSize) {
      return titleSize;
    } else {
      return messageSize;
    }
  }

  Size size = MediaQuery.of(context).size;
  Timer timer = Timer(Duration(milliseconds: showTime), () => Navigator.pop(context));
  showGeneralDialog(
    barrierLabel: "",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 200),
    context: context,
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
    pageBuilder: (_, __, ___) {
      return SafeArea(
        child: Align(
          alignment: alignment,
          child: WillPopScope(
            onWillPop: () {
              timer.cancel();
              return Future(() => true);
            },
            child: Container(
              width: isSmallAlert ? (titleSize + size.width * 0.15) : (getSize() + size.width * 0.15),
              margin: EdgeInsets.only(right: size.width * 0.03, left: size.width * 0.03),
              padding: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: size.width * 0.02),
              decoration: BoxDecoration(
                  gradient: LinearGradient(stops: [0.02, 0.02], colors: [dialogType.value.color, AppColors.nearlyBlack]),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
              child: Row(
                children: [
                  Icon(dialogType.value.icon, color: dialogType.value.color, size: size.width * 0.07),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title ?? dialogType.value.title,
                            style: TextStyle(color: dialogType.value.color, fontFamily: "Roboto", fontWeight: FontWeight.bold, fontSize: FontSizeValue.NORMAL, decoration: TextDecoration.none)),
                        isSmallAlert
                            ? Container()
                            : Text(message ?? dialogType.value.message,
                                style: const TextStyle(fontSize: FontSizeValue.SMALL, fontFamily: "Roboto", color: AppColors.white, fontWeight: FontWeight.normal, decoration: TextDecoration.none)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

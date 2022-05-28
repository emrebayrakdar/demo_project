import 'package:flutter/material.dart';

enum AlertDialogType { WARNING, ERROR, SUCCESS, INFO }

class CustomAlertDialogClass {
  String title;
  String message;
  Color color;
  IconData icon;

  CustomAlertDialogClass({required this.title, required this.message, required this.color, required this.icon});
}

extension AlertDialogs on AlertDialogType {
  CustomAlertDialogClass get value {
    switch (this) {
      case AlertDialogType.INFO:
        return CustomAlertDialogClass(color: Color(0xFF3086eb), title: 'Bilgilendirme', icon: Icons.info, message: 'Bilgilendirme işlemi başarılı');
      case AlertDialogType.SUCCESS:
        return CustomAlertDialogClass(color: Color(0xFF48d866), title: 'İşlem Başarılı', icon: Icons.check_circle, message: 'İşlem başarılı');
      case AlertDialogType.WARNING:
        return CustomAlertDialogClass(color: Color(0xFF3086eb), title: 'Uyarı', icon: Icons.warning, message: 'Lütfen daha sonra tekrar deneyiniz');
      case AlertDialogType.ERROR:
        return CustomAlertDialogClass(color: Color(0xFFff6b5f), title: 'Hata', icon: Icons.error, message: 'İşlem başarısız!');
    }
  }
}

import 'package:easy_localization/easy_localization.dart';

extension StringLocalization on String {
  String get locale => this.tr();
}


enum DateTimeTypeConstans { ddMMyyyyHHmmss, ddMMyyyy, yyyyMMddHHmmss, hhMM ,yyyyMMdd,eeee,mmmm}

extension DateTimeTypeExtensions on DateTimeTypeConstans {
  String get rawValue {
    switch (this) {
      case DateTimeTypeConstans.ddMMyyyyHHmmss:
        return "dd-MM-yyyy HH:mm:ss";
      case DateTimeTypeConstans.ddMMyyyy:
        return "dd-MM-yyyy";
      case DateTimeTypeConstans.yyyyMMddHHmmss:
        return "yyyy-MM-dd HH:mm:ss";
      case DateTimeTypeConstans.hhMM:
        return "HH:mm";
      case DateTimeTypeConstans.yyyyMMdd:
        return 'yyyy-MM-dd';
      case DateTimeTypeConstans.eeee:
        return 'EEEE';
      case DateTimeTypeConstans.mmmm:
        return 'MMMM';
    }
  }
}

//DateTime olan nesneyi formatlayıp string'e çevir
extension DateTimeExtensions on DateTime {
  String? toDateString(DateTimeTypeConstans pattern) {
    try {
      return new DateFormat(pattern.rawValue,'tr').format(this);
    } catch (e) {
      return null;
    }
  }
}

//String olan nesneyi formatlayıp tekrar string döndür!
extension StringExtensions on String {
  String? toDateFormat(DateTimeTypeConstans pattern) {
    try {
      return DateFormat(pattern.rawValue,'tr').format(DateTime.parse(this));
    } catch (e) {
      return null;
    }
  }

  //string olan tarihi format farketmeksizin olduğu gibi date'e çevirir
  DateTime? toDate() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }
}

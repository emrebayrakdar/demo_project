import 'package:demo_project/base/rx/rx_list/rx_list.dart';
import 'package:demo_project/base/rx/rx_value/rx_value.dart';
import 'package:flutter/foundation.dart';

///Reaktif değerleri dinlemek için servislerimizi bu mixin'den extend edeceğiz.
mixin RxServiceMixin {
  List<Function> _listeners = List<Function>.empty(growable: true);

  ///Servisleri içerisinde override edilen servis instancelarını type'larına göre değerlerini dinlemeye başlayalım.
  void listenRxValues(List<dynamic> list) {
    list.forEach((value) {
      if (value is RxValue)
        value.values.listen((value) => notifyListeners());
      else if (value is RxList)
        value.onChange.listen((event) => notifyListeners());
      else if (value is ChangeNotifier) value.addListener(notifyListeners);
    });
  }

  /// Listener'i ekleyelim
  void addListener(void Function() listener) => _listeners.add(listener);

  /// Listener'i silelim, dispose olduğunda gerekecek.
  void removeListener(void Function() listener) => _listeners.remove(listener);

  /// Servisi kullanan tüm listener'ları bilgilendirelim.
  @protected
  @visibleForTesting
  void notifyListeners() => _listeners.forEach((element) => element());
}

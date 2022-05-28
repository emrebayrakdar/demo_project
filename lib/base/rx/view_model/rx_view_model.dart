import 'package:demo_project/base/rx/rx_service_mixin/rx_service_mixin.dart';

import '../../model/base_view_model.dart';

abstract class RxViewModel extends BaseViewModel {
  late List<RxServiceMixin> _rxServices;

  List<RxServiceMixin> get rxServices;

  RxViewModel() {
    _rxServices = rxServices;
    for (var rxSvc in _rxServices) rxSvc.addListener(_notifyChange);
  }

  @override
  void dispose() {
    for (var rxSvc in _rxServices) rxSvc.removeListener(_notifyChange);
    super.dispose();
  }

  void _notifyChange() => notifyListeners();
}

import 'dart:async';
import 'package:demo_project/base/rx/rx_value/stored_value.dart';
import '../type_def.dart';
import 'proxy_value.dart';

abstract class RxValue<T> {
  factory RxValue(T initial) => StoredValue<T>(initial);

  factory RxValue.proxy(ValueGetter<T> getterProxy) => ProxyValue<T>(getterProxy);

  T get value;

  set value(T val);

  void setCast(dynamic val);

  Stream<Change<T>> get onChange;

  Stream<T> get values;

  void bindOrSet(other);

  void bind(RxValue<T> other);

  void bindStream(Stream<T> stream);

  StreamSubscription<T> listen(ValueCallback<T> callback);

  Stream<R> map<R>(R mapper(T data));
}

class Change<T> {
  final T old;
  final T neu;

  final DateTime time;

  final int batch;

  Change(
    this.neu,
    this.old,
    this.batch, {
    DateTime? time,
  }) : time = DateTime.now();

  String toString() => 'Değişenler (new: $neu, old: $old)';
}

import 'dart:async';
import 'package:demo_project/base/rx/rx_value/rx_value.dart';

import '../type_def.dart';

class ProxyValue<T> implements RxValue<T> {
  ValueGetter<T> getterProxy;

  final StreamController<Change<T>> _controller;

  int _curBatch = 0;

  ProxyValue._(this._controller, this._onChange, this.getterProxy);

  factory ProxyValue(ValueGetter<T> getterProxy) {
    // ignore: close_sinks
    final controller = StreamController<Change<T>>();
    final onChange = controller.stream.asBroadcastStream();

    return ProxyValue._(controller, onChange, getterProxy);
  }

  T get value => getterProxy();
  set value(T val) {
    T old = value;
    if (old == val) {
      return;
    }
    _controller.add(Change<T>(val, old, _curBatch));
  }

  void setCast(dynamic /* T */ val) => value = val;

  Stream<Change<T>> _onChange;

  Stream<Change<T>> get onChange {
    _curBatch++;
    // ignore: close_sinks
    final ret = StreamController<Change<T>>();
    ret.add(Change<T>(value, value, _curBatch));
    ret.addStream(_onChange.skipWhile((v) => v.batch < _curBatch));
    return ret.stream.asBroadcastStream();
  }

  Stream<T> get values => onChange.map((c) => c.neu);

  void bind(RxValue<T> rx) {
    value = rx.value;
    rx.values.listen((v) => value = v);
  }

  void bindStream(Stream<T> stream) => stream.listen((v) => value = v);

  void bindOrSet(other) {
    if (other is RxValue<T>) {
      bind(other);
    } else if (other is Stream<T>) {
      bindStream(other.cast<T>());
    } else {
      value = other;
    }
  }

  StreamSubscription<T> listen(ValueCallback<T> callback) =>
      values.listen(callback);

  Stream<R> map<R>(R mapper(T data)) => values.map(mapper);
}
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class InheritanceViewModelWidget<T> extends Widget {
  final bool isReactive;

  const InheritanceViewModelWidget({Key? key, this.isReactive = true}) : super(key: key);

  Widget build(BuildContext context, T viewModel);

  @override
  _DataElement<T> createElement() => _DataElement<T>(this);
}

class _DataElement<T> extends ComponentElement {
  _DataElement(InheritanceViewModelWidget widget) : super(widget);

  @override
  InheritanceViewModelWidget get widget {
    return super.widget as InheritanceViewModelWidget<dynamic>;
  }

  @override
  Widget build() {
    return widget.build(this, Provider.of<T>(this, listen: widget.isReactive));
  }


  @override
  void update(InheritanceViewModelWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
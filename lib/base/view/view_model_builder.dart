import 'package:demo_project/base/model/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ProviderType { WithoutConsumer, WithConsumer }

class ViewModelBuilder<T extends BaseViewModel> extends StatefulWidget {
  final T Function() viewModelBuilder;
  final Function(T)? onInitState;
  final Widget Function(BuildContext context, T model, Widget? child, Size pageSize) onPageBuilder;
  final Function(T)? onDispose;
  final ProviderType providerType;
  final bool disposeViewModel;

  const ViewModelBuilder.withConsumer({required this.viewModelBuilder, required this.onInitState, required this.onPageBuilder, this.onDispose, this.disposeViewModel = true, Key? key})
      : providerType = ProviderType.WithConsumer,
        super(key: key);

  const ViewModelBuilder.withoutConsumer(
      {required this.viewModelBuilder, required this.onInitState, required this.onPageBuilder, this.onDispose, this.disposeViewModel = true, Key? key})
      : providerType = ProviderType.WithoutConsumer,
        super(key: key);

  @override
  _ViewModelBuilderState<T> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends BaseViewModel> extends State<ViewModelBuilder<T>> {
  late T model;

  @override
  void initState() {
    super.initState();
    model = widget.viewModelBuilder();
    if (widget.onInitState != null) widget.onInitState!(model);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onDispose != null) widget.onDispose!(model);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.providerType == ProviderType.WithoutConsumer) {
      Size pageSize = (MediaQuery.of(context).size);
      if (widget.disposeViewModel) {
        return ChangeNotifierProvider<T>(create: (context) => model, child: widget.onPageBuilder(context, model, null, pageSize));
      } else {
        return ChangeNotifierProvider<T>.value(value: model, child: widget.onPageBuilder(context, model, null, pageSize));
      }
    } else {
      if (widget.disposeViewModel) {
        return ChangeNotifierProvider<T>(create: (context) => model, child: Consumer<T>(builder: buildConsumerInitialise));
      } else {
        return ChangeNotifierProvider<T>.value(value: model, child: Consumer<T>(builder: buildConsumerInitialise));
      }
    }
  }

  Widget buildConsumerInitialise(BuildContext context, T viewModel, Widget? child) {
    return widget.onPageBuilder(context, viewModel, child, (MediaQuery.of(context).size));
  }
}

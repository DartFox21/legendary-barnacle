import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class BaseModelWidget<T> extends Widget {
  const BaseModelWidget({Key? key}) : super(key: key);

  @protected
  Widget build(BuildContext context, T model);

  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T> extends ComponentElement {
  _DataProviderElement(BaseModelWidget widget) : super(widget);

  @override
  BaseModelWidget get widget => super.widget as BaseModelWidget;

  @override
  Widget build() => widget.build(this, Provider.of<T>(this));
}

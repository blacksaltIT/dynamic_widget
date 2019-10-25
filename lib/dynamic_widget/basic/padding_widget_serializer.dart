import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class PaddingWidgetSerializer implements WidgetSerializer {
  String widgetName = "Padding";

  @override
  bool forWidget(Widget widget) {
    return widget is Padding;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Padding padding = widget as Padding;

    return {
      'padding': serializeEdgeInsetsGeometry(padding.padding),
      'child': DynamicWidgetBuilder().serialize(padding.child)
    };
  }
}

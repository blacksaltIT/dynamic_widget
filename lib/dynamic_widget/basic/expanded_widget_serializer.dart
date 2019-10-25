import 'package:flutter/widgets.dart';

import '../../dynamic_widget.dart';

class ExpandedWidgetSerializer extends WidgetSerializer {
  String widgetName = "Expanded";

  @override
  bool forWidget(Widget widget) {
    return widget is Expanded;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Expanded expanded = widget as Expanded;

    return {
      'flex': expanded.flex,
      'child': DynamicWidgetBuilder().serialize(expanded.child)
    };
  }
}

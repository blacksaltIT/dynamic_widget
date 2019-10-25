import 'package:flutter/widgets.dart';

import '../../dynamic_widget.dart';

class CenterWidgetSerializer implements WidgetSerializer {
  String widgetName = "Center";

  @override
  bool forWidget(Widget widget) {
    return widget is Center;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Center center = widget as Center;

    return {
      'widthFactor': center.widthFactor,
      'heightFactor': center.heightFactor,
      'child': DynamicWidgetBuilder().serialize(center.child)
    };
  }
}

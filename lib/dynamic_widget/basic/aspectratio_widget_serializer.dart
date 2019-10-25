import 'package:flutter/widgets.dart';

import '../../dynamic_widget.dart';

class AspectRatioWidgetSerializer implements WidgetSerializer {
  String widgetName = "AspectRatio";

  @override
  bool forWidget(Widget widget) {
    return widget is AspectRatio;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    AspectRatio aspectRatio = widget as AspectRatio;

    return {
      'aspectRatio': aspectRatio.aspectRatio,
      'child': DynamicWidgetBuilder().serialize(aspectRatio.child)
    };
  }
}

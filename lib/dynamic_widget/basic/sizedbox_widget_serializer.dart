import 'package:flutter/widgets.dart';

import 'dynamic_widget_serializer.dart';

class SizedBoxWidgetSerializer implements WidgetSerializer {
  String widgetName = "SizedBox";

  @override
  bool forWidget(Widget widget) {
    return widget is SizedBox;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    SizedBox sizedBox = widget as SizedBox;

    return {
      'name': sizedBox.width == double.infinity &&
              sizedBox.height == double.infinity
          ? "ExpandedSizedBox"
          : "SizedBox",
      'width': sizedBox.width == double.infinity ? null : sizedBox.width,
      'height': sizedBox.height == double.infinity ? null : sizedBox.height,
      'child': DynamicWidgetSerializer().serialize(sizedBox.child)
    };
  }
}

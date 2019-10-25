import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class ClipRRectWidgetSerializer extends WidgetSerializer {
  String widgetName = "ClipRRect";

  @override
  bool forWidget(Widget widget) {
    return widget is ClipRRect;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    ClipRRect clipRRect = widget as ClipRRect;

    return {
      'borderRadius': serializeBorderRadius(clipRRect.borderRadius),
      'clipBehavior': serializeClipBehavior(clipRRect.clipBehavior),
      'child': DynamicWidgetBuilder().serialize(clipRRect.child)
    };
  }
}

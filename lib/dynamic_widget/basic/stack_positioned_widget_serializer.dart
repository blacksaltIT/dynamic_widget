import '../utils.dart';
import 'package:flutter/widgets.dart';

import 'dynamic_widget_serializer.dart';

class StackWidgetSerializer implements WidgetSerializer {
  String widgetName = "Stack";

  @override
  bool forWidget(Widget widget) {
    return widget is Stack;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Stack stack = widget as Stack;

    return {
      'alignment': serializeAlignment(stack.alignment),
      'textDirection': serializeTextDirection(stack.textDirection),
      'fit': serializeStackFit(stack.fit),
      'overflow': serializeOwerflow(stack.overflow),
      'children':
          DynamicWidgetSerializer().serializeList(stack.children)
    };
  }
}

class IndexedStackWidgetSerializer implements WidgetSerializer {
  String widgetName = "IndexedStack";

  @override
  bool forWidget(Widget widget) {
    return widget is IndexedStack;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    IndexedStack stack = widget as IndexedStack;

    return {
      'alignment': serializeAlignment(stack.alignment),
      'textDirection': serializeTextDirection(stack.textDirection),
      'fit': serializeStackFit(stack.fit),
      'overflow': serializeOwerflow(stack.overflow),
      'index': stack.index,
      'children':
          DynamicWidgetSerializer().serializeList(stack.children)
    };
  }
}

class PositionedWidgetSerializer implements WidgetSerializer {
  String widgetName = "Positioned";

  @override
  bool forWidget(Widget widget) {
    return widget is Positioned;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Positioned positioned = widget as Positioned;

    return {
      'left': positioned.left,
      'right': positioned.right,
      'top': positioned.top,
      'bottom': positioned.bottom,
      'width': positioned.width,
      'height': positioned.height,
      'child': DynamicWidgetSerializer().serialize(positioned.child)
    };
  }
}

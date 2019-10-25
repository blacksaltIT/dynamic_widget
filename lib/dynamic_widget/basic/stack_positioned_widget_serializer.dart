import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

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
          DynamicWidgetBuilder().serializeList(stack.children)
    };
  }
}


class PositionedWidgetSerializer extends WidgetSerializer {
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
      'child': DynamicWidgetBuilder().serialize(positioned.child)
    };
  }
}

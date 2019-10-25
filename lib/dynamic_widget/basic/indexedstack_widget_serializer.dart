import 'package:flutter/widgets.dart';

import '../../dynamic_widget.dart';
import '../utils.dart';

class IndexedStackWidgetSerializer extends WidgetSerializer {
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
          DynamicWidgetBuilder().serializeList(stack.children)
    };
  }
}
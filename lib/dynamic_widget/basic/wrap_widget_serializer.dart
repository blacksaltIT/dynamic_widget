import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class WrapWidgetSerializer implements WidgetSerializer {
  String widgetName = "Wrap";

  @override
  bool forWidget(Widget widget) {
    return widget is Wrap;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Wrap wrap = widget as Wrap;

    return {
      'alignment': serializeWrapAlignment(wrap.alignment),
      'direction': serializeAxis(wrap.direction),
      'spacing': wrap.spacing,
      'crossAxisAlignment':
          serializeWrapCrossAlignment(wrap.crossAxisAlignment),
      'textDirection': serializeTextDirection(wrap.textDirection),
      'verticalDirection': serializeVerticalDirection(wrap.verticalDirection),
      'runSpacing': wrap.runSpacing,
      'runAlignment': serializeWrapAlignment(wrap.runAlignment),
      'children': DynamicWidgetBuilder().serializeList(wrap.children)
    };
  }
}

import 'package:flutter/widgets.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';

class PlaceholderWidgetSerializer implements WidgetSerializer {
  String widgetName = "Placeholder";

  @override
  bool forWidget(Widget widget) {
    return widget is Placeholder;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Placeholder placeholder = widget as Placeholder;

    return {
      'color': serializeColor(placeholder.color),
      'strokeWidth': placeholder.strokeWidth,
      'fallbackWidth': placeholder.fallbackWidth,
      'fallbackHeight': placeholder.fallbackHeight
    };
  }
}

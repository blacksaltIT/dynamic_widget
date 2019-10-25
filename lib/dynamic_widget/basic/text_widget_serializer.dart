import 'package:flutter/widgets.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';

class TextWidgetSerializer implements WidgetSerializer {
  String widgetName = "Text";

  @override
  bool forWidget(Widget widget) {
    return widget is Text;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Text text = widget as Text;

    return {
      'data': text.data,
      'style': serializeTextStyle(text.style),
      'align': serializeTextAlign(text.textAlign)
    };
  }
}

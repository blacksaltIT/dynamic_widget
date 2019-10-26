import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class PaddingWidgetParser extends WidgetParser {
  final String widgetName = "Padding";

  @override
  bool forSerialize(Widget widget) {
    return widget is Padding;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Padding padding = widget as Padding;

    return {
      'padding': serializeEdgeInsetsGeometry(padding.padding),
      'child': DynamicWidgetBuilder().serialize(padding.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Padding(
      padding: map.containsKey("padding")
          ? parseEdgeInsetsGeometry(map["padding"])
          : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

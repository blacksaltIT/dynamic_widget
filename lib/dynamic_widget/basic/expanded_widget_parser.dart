import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class ExpandedWidgetParser extends WidgetParser {
  final String widgetName = "Expanded";

  @override
  bool forSerialize(dynamic widget) {
    return widget is Expanded;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Expanded expanded = widget as Expanded;

    return {
      'flex': expanded.flex,
      'child': DynamicWidgetBuilder().serialize(expanded.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Expanded(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
      flex: map.containsKey("flex") ? map["flex"] : 1,
    );
  }
}

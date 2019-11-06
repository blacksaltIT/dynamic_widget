import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class ClipOvalWidgetParser extends WidgetParser {
  final String widgetName = "ClipOval";

  @override
  bool forSerialize(Widget widget) {
    return widget is ClipOval;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    ClipOval clipRRect = widget as ClipOval;

    return {
      'clipBehavior': serializeClipBehavior(clipRRect.clipBehavior),
      'child': DynamicWidgetBuilder().serialize(clipRRect.child)
    };
  }
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    var clipBehaviorString = map['clipBehavior'];
    return ClipOval(
      clipBehavior: parseClipBehavior(clipBehaviorString),
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

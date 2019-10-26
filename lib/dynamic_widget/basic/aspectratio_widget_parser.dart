import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class AspectRatioWidgetParser extends WidgetParser {
  final String widgetName = "AspectRatio";

  @override
  bool forSerialize(Widget widget) {
    return widget is AspectRatio;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    AspectRatio aspectRatio = widget as AspectRatio;

    return {
      'aspectRatio': aspectRatio.aspectRatio,
      'child': DynamicWidgetBuilder().serialize(aspectRatio.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return AspectRatio(
      aspectRatio: map["aspectRatio"],
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

//Creates a box that will become as large as its parent allows.
class ExpandedSizedBoxWidgetParser extends WidgetParser {
  final String widgetName = "ExpandedSizedBox";

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return SizedBox.expand(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

class SizedBoxWidgetParser extends WidgetParser {
  final String widgetName = "SizedBox";

  @override
  bool forSerialize(Widget widget) {
    return widget is SizedBox;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    SizedBox sizedBox = widget as SizedBox;

    return {
      'name': sizedBox.width == double.infinity &&
              sizedBox.height == double.infinity
          ? "ExpandedSizedBox"
          : "SizedBox",
      'width': sizedBox.width == double.infinity ? null : sizedBox.width,
      'height': sizedBox.height == double.infinity ? null : sizedBox.height,
      'child': DynamicWidgetBuilder().serialize(sizedBox.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return SizedBox(
      width: map["width"],
      height: map["height"],
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

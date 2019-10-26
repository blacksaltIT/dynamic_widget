import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class CenterWidgetParser extends WidgetParser {
  final String widgetName = "Center";

  @override
  bool forSerialize(Widget widget) {
    return widget is Center;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Center center = widget as Center;

    return {
      'widthFactor': center.widthFactor,
      'heightFactor': center.heightFactor,
      'child': DynamicWidgetBuilder().serialize(center.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Center(
      widthFactor: map.containsKey("widthFactor") ? map["widthFactor"] : null,
      heightFactor:
          map.containsKey("heightFactor") ? map["heightFactor"] : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

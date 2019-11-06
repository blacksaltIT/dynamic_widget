import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class OpacityWidgetParser extends WidgetParser {
  final String widgetName = "Opacity";

  @override
  bool forSerialize(dynamic widget) {
    return widget is Opacity;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Opacity opacity = widget as Opacity;

    return {
      'alwaysIncludeSemantics': opacity.alwaysIncludeSemantics,
      'opacity': opacity.opacity,
      'child': DynamicWidgetBuilder().serialize(opacity.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Opacity(
      opacity: map["opacity"],
      alwaysIncludeSemantics: map.containsKey("alwaysIncludeSemantics")
          ? map["alwaysIncludeSemantics"]
          : false,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

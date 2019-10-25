import 'package:flutter/widgets.dart';
import '../../dynamic_widget.dart';

class OpacityWidgetSerializer extends WidgetSerializer {
  String widgetName = "Opacity";

  @override
  bool forWidget(Widget widget) {
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
}

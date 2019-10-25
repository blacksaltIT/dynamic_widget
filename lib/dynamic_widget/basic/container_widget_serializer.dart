import 'package:flutter/widgets.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';

class ContainerWidgetSerializer extends WidgetSerializer {
  String widgetName = "Container";

  @override
  bool forWidget(Widget widget) {
    return widget is Container;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Container container = widget as Container;

    return {
      'alignment': serializeAlignment(container.alignment),
      'width': container.constraints.minWidth == 0.0
          ? null
          : container.constraints.minWidth,
      'height': container.constraints.minHeight == 0.0
          ? null
          : container.constraints.minHeight,
      'color': container.decoration is BoxDecoration
          ? serializeColor((container.decoration as BoxDecoration).color)
          : null,
      'constraints': serializeBoxConstraints(container.constraints),
      'margin': serializeEdgeInsetsGeometry(container.margin),
      'padding': serializeEdgeInsetsGeometry(container.padding),
      'child': DynamicWidgetBuilder().serialize(container.child)
    };
  }
}

import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class ContainerWidgetParser extends WidgetParser {
  final String widgetName = "Container";

  @override
  bool forSerialize(Widget widget) {
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

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    Alignment alignment = parseAlignment(map['alignment']);
    Color color = parseHexColor(map['color']);
    BoxConstraints constraints = parseBoxConstraints(map['constraints']);
    //TODO: decoration, foregroundDecoration and transform properties to be implemented.
    EdgeInsetsGeometry margin = parseEdgeInsetsGeometry(map['margin']);
    EdgeInsetsGeometry padding = parseEdgeInsetsGeometry(map['padding']);
    Map<String, dynamic> childMap = map['child'];
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);

    String clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var containerWidget = Container(
      alignment: alignment,
      padding: padding,
      color: color,
      margin: margin,
      width: map['width'],
      height: map['height'],
      constraints: constraints,
      child: child,
    );

    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }
}

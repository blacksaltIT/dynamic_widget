import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class PositionedWidgetParser extends WidgetParser {
  final String widgetName = "Positioned";

  @override
  bool forSerialize(Widget widget) {
    return widget is Positioned;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Positioned positioned = widget as Positioned;

    return {
      'left': positioned.left,
      'right': positioned.right,
      'top': positioned.top,
      'bottom': positioned.bottom,
      'width': positioned.width,
      'height': positioned.height,
      'child': DynamicWidgetBuilder().serialize(positioned.child)
    };
  }
  
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Positioned(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
      top: map.containsKey("top") ? map["top"] : null,
      right: map.containsKey("right") ? map["right"] : null,
      bottom: map.containsKey("bottom") ? map["bottom"] : null,
      left: map.containsKey("left") ? map["left"] : null,
      width: map.containsKey("width") ? map["width"] : null,
      height: map.containsKey("height") ? map["height"] : null,
    );
  }
}

class StackWidgetParser extends WidgetParser {
  final String widgetName = "Stack";

  @override
  bool forSerialize(Widget widget) {
    return widget is Stack;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Stack stack = widget as Stack;

    return {
      'alignment': serializeAlignment(stack.alignment),
      'textDirection': serializeTextDirection(stack.textDirection),
      'fit': serializeStackFit(stack.fit),
      'overflow': serializeOwerflow(stack.overflow),
      'children':
          DynamicWidgetBuilder().serializeList(stack.children)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Stack(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])
          : AlignmentDirectional.topStart,
      textDirection: map.containsKey("textDirection")
          ? parseTextDirection(map["textDirection"])
          : null,
      fit: map.containsKey("fit") ? parseStackFit(map["fit"]) : StackFit.loose,
      overflow: map.containsKey("overflow")
          ? parseOverflow(map["overflow"])
          : Overflow.clip,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }
}

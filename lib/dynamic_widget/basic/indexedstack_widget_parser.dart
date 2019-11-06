import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class IndexedStackWidgetParser extends WidgetParser {
  final String widgetName = "IndexedStack";

  @override
  bool forSerialize(dynamic widget) {
    return widget is IndexedStack;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    IndexedStack stack = widget as IndexedStack;

    return {
      'alignment': serializeAlignment(stack.alignment),
      'textDirection': serializeTextDirection(stack.textDirection),
      'fit': serializeStackFit(stack.fit),
      'overflow': serializeOwerflow(stack.overflow),
      'index': stack.index,
      'children':
          DynamicWidgetBuilder().serializeList(stack.children)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return IndexedStack(
      index: map.containsKey("index") ? map["index"] : 0,
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])
          : AlignmentDirectional.topStart,
      textDirection: map.containsKey("textDirection")
          ? parseTextDirection(map["textDirection"])
          : null,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }
}

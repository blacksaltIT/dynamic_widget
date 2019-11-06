import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

abstract class ClipPathWidgetParser extends WidgetParser {
  final String widgetName = "ClipPath";

  @override
  bool forSerialize(dynamic widget) {
    return widget is ClipPath;
  }

  @override
  Map<String, dynamic> serialize(dynamic widget) {
    ClipPath clipPath = widget as ClipPath;

    return <String, dynamic>{
      'clipper': serializeClipper(clipPath.clipper),
      'child': DynamicWidgetBuilder().serialize(clipPath.child),
    };
  }

  Map<String, dynamic> serializeClipper(dynamic widget);
  CustomClipper<Path> parseClipper(Map<String, dynamic> map,
      BuildContext buildContext, ClickListener listener);

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    Map<String, dynamic> childMap = map['child'] as Map<String, dynamic>;
    Widget child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);

    return ClipPath(
      clipper: parseClipper(map["clipper"], buildContext, listener),
      child: child,
    );
  }
}

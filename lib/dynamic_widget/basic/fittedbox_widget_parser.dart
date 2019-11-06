import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class FittedBoxWidgetParser extends WidgetParser {
  final String widgetName = "FittedBox";

  @override
  bool forSerialize(dynamic widget) {
    return widget is FittedBox;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    FittedBox fittedBox = widget as FittedBox;

    return {
      'alignment': serializeAlignment(fittedBox.alignment),
      'fit': serializeBoxFit(fittedBox.fit),
      'child': DynamicWidgetBuilder().serialize(fittedBox.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return FittedBox(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])
          : Alignment.center,
      fit: map.containsKey("fit") ? parseBoxFit(map["fit"]) : BoxFit.contain,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

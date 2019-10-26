import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class AlignWidgetParser extends WidgetParser {
  final String widgetName = "Align";

  @override
  bool forSerialize(Widget widget) {
    return widget is Align;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Align alignment = widget as Align;

    return {
      'alignment': serializeAlignment(alignment.alignment),
      'widthFactor': alignment.widthFactor,
      'heightFactor': alignment.heightFactor,
      'child': DynamicWidgetBuilder().serialize(alignment.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Align(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])
          : Alignment.center,
      widthFactor: map.containsKey("widthFactor") ? map["widthFactor"] : null,
      heightFactor:
          map.containsKey("heightFactor") ? map["heightFactor"] : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

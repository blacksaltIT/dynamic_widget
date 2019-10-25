
import 'package:flutter/widgets.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';

class AlignWidgetSerializer extends WidgetSerializer {
  String widgetName = "Align";

  @override
  bool forWidget(Widget widget) {
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
}

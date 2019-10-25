import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class FittedBoxWidgetSerializer extends WidgetSerializer {
  String widgetName = "FittedBox";

  @override
  bool forWidget(Widget widget) {
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
}

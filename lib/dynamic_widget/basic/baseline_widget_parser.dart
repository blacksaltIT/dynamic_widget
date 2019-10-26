import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

import '../utils.dart';

class BaselineWidgetParser extends WidgetParser {
  final String widgetName = "Baseline";

  @override
  bool forSerialize(Widget widget) {
    return widget is Baseline;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Baseline baseline = widget as Baseline;

    return {
      'baseline': baseline.baseline,
      'baselineType': serializeTextBaseline(baseline.baselineType),
      'child': DynamicWidgetBuilder().serialize(baseline.child)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Baseline(
      baseline: map["baseline"],
      baselineType: map["baselineType"] == "alphabetic"
          ? TextBaseline.alphabetic
          : TextBaseline.ideographic,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }
}

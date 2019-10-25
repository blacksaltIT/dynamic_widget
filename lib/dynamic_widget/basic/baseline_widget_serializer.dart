import 'package:eflyr/util/engine/serializer/utils.dart';
import 'package:flutter/widgets.dart';

import 'dynamic_widget_serializer.dart';

class BaselineWidgetSerializer implements WidgetSerializer {
  String widgetName = "Baseline";

  @override
  bool forWidget(Widget widget) {
    return widget is Baseline;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Baseline baseline = widget as Baseline;

    return {
      'baseline': baseline.baseline,
      'baselineType': serializeTextBaseline(baseline.baselineType),
      'child': DynamicWidgetSerializer().serialize(baseline.child)
    };
  }
}

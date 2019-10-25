import 'package:dynamic_widget/dynamic_widget/basic/button_widget_parser.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RaisedButtonWidgetSerializer extends WidgetSerializer {
  String widgetName = "RaisedButton";

  @override
  bool forWidget(Widget widget) {
    return widget is EventHolder && widget.child is RaisedButton;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    EventHolder eventHolder = widget as EventHolder;
    RaisedButton raisedButton = eventHolder.child as RaisedButton;

    return {
      'click_event': eventHolder.events['click_event'],
      'color': serializeColor(raisedButton.color),
      'disabledColor': serializeColor(raisedButton.disabledColor),
      'disabledTextColor': serializeColor(raisedButton.disabledTextColor),
      'elevation': raisedButton.elevation,
      'padding': serializeEdgeInsetsGeometry(raisedButton.padding),
      'splashColor': serializeColor(raisedButton.splashColor),
      'textColor': serializeColor(raisedButton.splashColor),
      'child': DynamicWidgetBuilder().serialize(raisedButton.child)
    };
  }
}

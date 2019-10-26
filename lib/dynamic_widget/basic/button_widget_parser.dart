import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

class EventHolder extends StatelessWidget {
  final Widget child;
  final Map<String, String> events;

  EventHolder({Key key, this.child, this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class RaisedButtonParser extends WidgetParser {
  final String widgetName = "RaisedButton";

  @override
  bool forSerialize(Widget widget) {
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

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    String clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var raisedButton = EventHolder(
        child: RaisedButton(
          color: map.containsKey('color') ? parseHexColor(map['color']) : null,
          disabledColor: map.containsKey('disabledColor')
              ? parseHexColor(map['disabledColor'])
              : null,
          disabledElevation: map.containsKey('disabledElevation')
              ? map['disabledElevation']
              : 0.0,
          disabledTextColor: map.containsKey('disabledTextColor')
              ? parseHexColor(map['disabledTextColor'])
              : null,
          elevation: map.containsKey('elevation') ? map['elevation'] : 0.0,
          padding: map.containsKey('padding')
              ? parseEdgeInsetsGeometry(map['padding'])
              : null,
          splashColor: map.containsKey('splashColor')
              ? parseHexColor(map['splashColor'])
              : null,
          textColor: map.containsKey('textColor')
              ? parseHexColor(map['textColor'])
              : null,
          child: DynamicWidgetBuilder.buildFromMap(
              map['child'], buildContext, listener),
          onPressed: () {
            listener.onClicked(clickEvent);
          },
        ),
        events: {'click_event': clickEvent});

    return raisedButton;
  }
}

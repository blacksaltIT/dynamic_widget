library dynamic_widget;

import 'package:dynamic_widget/dynamic_widget/basic/align_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/aspectratio_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/baseline_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/button_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/center_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/container_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/expanded_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/fittedbox_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/image_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/indexedstack_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/opacity_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/padding_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/placeholder_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/row_column_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/sizedbox_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/text_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/basic/wrap_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/scrolling/gridview_widget_parser.dart';
import 'package:dynamic_widget/dynamic_widget/scrolling/listview_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:logging/logging.dart';

import 'dynamic_widget/basic/align_widget_serializer.dart';
import 'dynamic_widget/basic/aspectratio_widget_serializer.dart';
import 'dynamic_widget/basic/baseline_widget_serializer.dart';
import 'dynamic_widget/basic/button_widget_serializer.dart';
import 'dynamic_widget/basic/center_widget_serializer.dart';
import 'dynamic_widget/basic/cliprrect_widget_parser.dart';
import 'dynamic_widget/basic/cliprrect_widget_serializer.dart';
import 'dynamic_widget/basic/container_widget_serializer.dart';
import 'dynamic_widget/basic/expanded_widget_serializer.dart';
import 'dynamic_widget/basic/fittedbox_widget_serializer.dart';
import 'dynamic_widget/basic/image_widget_serializer.dart';
import 'dynamic_widget/basic/indexedstack_widget_serializer.dart';
import 'dynamic_widget/basic/opacity_widget_serializer.dart';
import 'dynamic_widget/basic/padding_widget_serializer.dart';
import 'dynamic_widget/basic/placeholder_widget_serializer.dart';
import 'dynamic_widget/basic/row_column_widget_serializer.dart';
import 'dynamic_widget/basic/sizedbox_widget_serializer.dart';
import 'dynamic_widget/basic/stack_positioned_widget_parser.dart';
import 'dynamic_widget/basic/stack_positioned_widget_serializer.dart';
import 'dynamic_widget/basic/text_widget_serializer.dart';
import 'dynamic_widget/basic/wrap_widget_serializer.dart';
import 'dynamic_widget/scrolling/gridview_widget_serializer.dart';
import 'dynamic_widget/scrolling/listview_widget_serializer.dart';
import 'dynamic_widget/scrolling/page_widget_parser.dart';
import 'dynamic_widget/scrolling/page_widget_serializer.dart';

class DynamicWidgetBuilder {
  static final Logger log = Logger('DynamicWidget');

  static final _parsers = [
    ContainerWidgetParser(),
    TextWidgetParser(),
    RaisedButtonParser(),
    RowWidgetParser(),
    ColumnWidgetParser(),
    AssetImageWidgetParser(),
    NetworkImageWidgetParser(),
    FileImageWidgetParser(),
    PlaceholderWidgetParser(),
    GridViewWidgetParser(),
    ListViewWidgetParser(),
    PageViewWidgetParser(),
    ExpandedWidgetParser(),
    PaddingWidgetParser(),
    CenterWidgetParser(),
    AlignWidgetParser(),
    AspectRatioWidgetParser(),
    FittedBoxWidgetParser(),
    BaselineWidgetParser(),
    StackWidgetParser(),
    PositionedWidgetParser(),
    IndexedStackWidgetParser(),
    ExpandedSizedBoxWidgetParser(),
    SizedBoxWidgetParser(),
    OpacityWidgetParser(),
    WrapWidgetParser(),
    ClipRRectWidgetParser()
  ];

  static final _serializers = [
    ContainerWidgetSerializer(),
    TextWidgetSerializer(),
    RowWidgetSerializer(),
    ColumnWidgetSerializer(),
    RaisedButtonWidgetSerializer(),
    AssetImageWidgetSerializer(),
    NetworkImageWidgetSerializer(),
    FileImageWidgetSerializer(),
    PlaceholderWidgetSerializer(),
    GridViewWidgetSerializer(),
    ListViewWidgetSerializer(),
    PageViewWidgetSerializer(),
    ExpandedWidgetSerializer(),
    PaddingWidgetSerializer(),
    CenterWidgetSerializer(),
    AlignWidgetSerializer(),
    AspectRatioWidgetSerializer(),
    FittedBoxWidgetSerializer(),
    BaselineWidgetSerializer(),
    StackWidgetSerializer(),
    PositionedWidgetSerializer(),
    IndexedStackWidgetSerializer(),
    SizedBoxWidgetSerializer(),
    OpacityWidgetSerializer(),
    WrapWidgetSerializer(),
    ClipRRectWidgetSerializer()
  ];

  // use this method for adding your custom widget parser
  static void addParser(WidgetParser parser) {
    log.info(
        "add custom widget parser, make sure you don't overwirte the widget type.");
    _parsers.insert(0,parser);
  }

  static void addSerializer(WidgetSerializer serializer) {
    log.info(
        "add custom widget Serializer, make sure you don't overwirte the widget type.");
    _serializers.insert(0,serializer);
  }

  Widget build(String json, BuildContext buildContext, ClickListener listener) {
    var map = jsonDecode(json);
    ClickListener _listener =
        listener == null ? new NonResponseWidgetClickListener() : listener;
    var widget = buildFromMap(map, buildContext, _listener);
    return widget;
  }

  static Widget buildFromMap(Map<String, dynamic> map,
      BuildContext buildContext, ClickListener listener) {
    String widgetName = map['type'];

    for (var parser in _parsers) {
      if (parser.forWidget(widgetName)) {
        return parser.parse(map, buildContext, listener);
      }
    }

    log.warning("Not support type: $widgetName");
    return null;
  }

  static List<Widget> buildWidgets(
      List<dynamic> values, BuildContext buildContext, ClickListener listener) {
    List<Widget> rt = [];
    for (var value in values) {
      rt.add(buildFromMap(value, buildContext, listener));
    }
    return rt;
  }

   Map<String, dynamic> serialize(Widget widget) {
    Widget widgetToSerialize = getWidgetToSerialize(widget);
    for (WidgetSerializer serializer in _serializers) {
      if (serializer.forWidget(widgetToSerialize)) {
        Map<String, dynamic> result = serializer.serialize(widgetToSerialize);
        result.putIfAbsent('type', () => serializer.widgetName);
        return result;
      }
    }

    log.warning("Not supported type: ${widget.toString()}");
    return null;
  }

  Widget getWidgetToSerialize(Widget widget) {
    if (widget is GestureDetector) return getWidgetToSerialize(widget.child);
    return widget;
  }

  List<Map<String, dynamic>> serializeList(List<Widget> widgets) {
    List<Map<String, dynamic>> list = [];
    for (Widget widget in widgets) {
      list.add(serialize(widget));
    }

    return list;
  }
}

/// extends this class to make a Flutter widget parser.
abstract class WidgetParser {
  /// parse the json map into a flutter widget.
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener);

  /// check the matched widget type. for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method as "Text" == widgetName, for more details, please see
  /// @TextWidgetParser
  bool forWidget(String widgetName);
}
 /// extends this class to make a Flutter widget Serializer.
abstract class WidgetSerializer {
  /// parse the json map into a flutter widget.
  Map<String, dynamic> serialize(Widget widget);

  /// check the matched widget type. for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method as "Text" == widgetName, for more details, please see
  /// @TextWidgetSerializer
  bool forWidget(Widget widget);
  String widgetName;
}

abstract class ClickListener {
  void onClicked(String event);
}

class NonResponseWidgetClickListener implements ClickListener {
  static final Logger log = Logger('NonResponseWidgetClickListener');

  @override
  void onClicked(String event) {
    log.info("receiver click event: " + event);
    print("receiver click event: " + event);
  }
}

import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

class RowWidgetParser extends WidgetParser {
  final String widgetName = "Row";

  @override
  bool forSerialize(Widget widget) {
    return widget is Row;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Row row = widget as Row;

    return {
      'crossAxisAlignment': serializeCrossAxisAlignment(row.crossAxisAlignment),
      'mainAxisAlignment': serializeMainAxisAlignment(row.mainAxisAlignment),
      'mainAxisSize': serializeMainAxisSize(row.mainAxisSize),
      'textBaseline': serializeTextBaseline(row.textBaseline),
      'textDirection': serializeTextDirection(row.textDirection),
      'verticalDirection': serializeVerticalDirection(row.verticalDirection),
      'children':
          DynamicWidgetBuilder().serializeList(row.children),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Row(
      crossAxisAlignment: map.containsKey('crossAxisAlignment')
          ? parseCrossAxisAlignment(map['crossAxisAlignment'])
          : CrossAxisAlignment.center,
      mainAxisAlignment: map.containsKey('mainAxisAlignment')
          ? parseMainAxisAlignment(map['mainAxisAlignment'])
          : MainAxisAlignment.start,
      mainAxisSize: map.containsKey('mainAxisSize')
          ? parseMainAxisSize(map['mainAxisSize'])
          : MainAxisSize.max,
      textBaseline: map.containsKey('textBaseline')
          ? parseTextBaseline(map['textBaseline'])
          : null,
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : null,
      verticalDirection: map.containsKey('verticalDirection')
          ? parseVerticalDirection(map['verticalDirection'])
          : VerticalDirection.down,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }
}

class ColumnWidgetParser extends WidgetParser {
  final String widgetName = "Column";

  @override
  bool forSerialize(Widget widget) {
    return widget is Row;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Column row = widget as Column;

    return {
      'crossAxisAlignment': serializeCrossAxisAlignment(row.crossAxisAlignment),
      'mainAxisAlignment': serializeMainAxisAlignment(row.mainAxisAlignment),
      'mainAxisSize': serializeMainAxisSize(row.mainAxisSize),
      'textBaseline': serializeTextBaseline(row.textBaseline),
      'textDirection': serializeTextDirection(row.textDirection),
      'verticalDirection': serializeVerticalDirection(row.verticalDirection),
      'children':
          DynamicWidgetBuilder().serializeList(row.children),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    return Column(
      crossAxisAlignment: map.containsKey('crossAxisAlignment')
          ? parseCrossAxisAlignment(map['crossAxisAlignment'])
          : CrossAxisAlignment.center,
      mainAxisAlignment: map.containsKey('mainAxisAlignment')
          ? parseMainAxisAlignment(map['mainAxisAlignment'])
          : MainAxisAlignment.start,
      mainAxisSize: map.containsKey('mainAxisSize')
          ? parseMainAxisSize(map['mainAxisSize'])
          : MainAxisSize.max,
      textBaseline: map.containsKey('textBaseline')
          ? parseTextBaseline(map['textBaseline'])
          : null,
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : null,
      verticalDirection: map.containsKey('verticalDirection')
          ? parseVerticalDirection(map['verticalDirection'])
          : VerticalDirection.down,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }
}

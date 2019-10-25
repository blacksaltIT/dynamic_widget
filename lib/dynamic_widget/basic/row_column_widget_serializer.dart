import 'package:flutter/widgets.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';

class RowWidgetSerializer implements WidgetSerializer {
  String widgetName = "Row";

  @override
  bool forWidget(Widget widget) {
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
}

class ColumnWidgetSerializer implements WidgetSerializer {
  String widgetName = "Column";

  @override
  bool forWidget(Widget widget) {
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
}

import 'package:dynamic_widget/dynamic_widget/scrolling/listview_widget_parser.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';


class ListViewWidgetSerializer extends WidgetSerializer {
  String widgetName = "ListView";

  @override
  bool forWidget(Widget widget) {
    return widget is ListViewWidget;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    ListViewWidget listViewWidget = widget as ListViewWidget;
    List<Widget> list = listViewWidget.state.items;

    return {
      'scrollDirection': serializeAxis(listViewWidget.state.params.scrollDirection),
      'reverse': listViewWidget.state.params.reverse,
      'shrinkWrap': listViewWidget.state.params.shrinkWrap,
      'cacheExtent': listViewWidget.state.params.cacheExtent,
      'padding': serializeEdgeInsetsGeometry(listViewWidget.state.params.padding),
      'pageSize': listViewWidget.state.params.pageSize,
      'itemExtent': listViewWidget.state.params.itemExtent,
      'loadMoreUrl': listViewWidget.state.params.loadMoreUrl,
      'isDemo': listViewWidget.state.params.isDemo,
      'children': DynamicWidgetBuilder().serializeList(list)
    };
  }
}

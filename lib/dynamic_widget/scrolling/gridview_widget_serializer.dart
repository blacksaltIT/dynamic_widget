import 'package:dynamic_widget/dynamic_widget/scrolling/gridview_widget_parser.dart';
import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';


class GridViewWidgetSerializer extends WidgetSerializer {
  String widgetName = "GridView";

  @override
  bool forWidget(Widget widget) {
    return widget is GridViewWidget;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    GridViewWidget listViewWidget = widget as GridViewWidget;
    List<Widget> list = listViewWidget.state.items;

    return {
      'scrollDirection':
          serializeAxis(listViewWidget.state.params.scrollDirection),
      'reverse': listViewWidget.state.params.reverse,
      'shrinkWrap': listViewWidget.state.params.shrinkWrap,
      'cacheExtent': listViewWidget.state.params.cacheExtent,
      'padding':
          serializeEdgeInsetsGeometry(listViewWidget.state.params.padding),
      'mainAxisSpacing': listViewWidget.state.params.mainAxisSpacing,
      'crossAxisSpacing': listViewWidget.state.params.crossAxisSpacing,
      'childAspectRatio': listViewWidget.state.params.childAspectRatio,
      'pageSize': listViewWidget.state.params.pageSize,
      'loadMoreUrl': listViewWidget.state.params.loadMoreUrl,
      'isDemo': listViewWidget.state.params.isDemo,
      'children': DynamicWidgetBuilder().serializeList(list)
    };
  }
}

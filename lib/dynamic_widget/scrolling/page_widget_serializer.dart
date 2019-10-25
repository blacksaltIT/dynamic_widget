import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';


class PageViewWidgetSerializer extends WidgetSerializer {
  String widgetName = "PageView";

  @override
  bool forWidget(Widget widget) {
    return widget is PageView;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    PageView page = widget as PageView;

    return {
      'scrollDirection': serializeAxis(page.scrollDirection),
      'reverse': page.reverse,
      'pageSnapping': page.pageSnapping,
      'children': DynamicWidgetBuilder().serializeList(
          (page.childrenDelegate as SliverChildListDelegate).children)
    };
  }
}

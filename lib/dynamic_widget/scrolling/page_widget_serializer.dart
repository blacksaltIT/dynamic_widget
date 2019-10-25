import 'package:eflyr/util/engine/serializer/utils.dart';
import 'package:flutter/widgets.dart';

import 'dynamic_widget_serializer.dart';

class PageViewWidgetSerializer implements WidgetSerializer {
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
      'children': DynamicWidgetSerializer().serializeList(
          (page.childrenDelegate as SliverChildListDelegate).children)
    };
  }
}

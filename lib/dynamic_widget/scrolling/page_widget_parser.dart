import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

import '../utils.dart';

class PageViewWidgetParser extends WidgetParser {
  final String widgetName = "PageView";

  @override
  bool forSerialize(Widget widget) {
    return widget is PageView;
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    var scrollDirection = Axis.horizontal;
    if (map.containsKey("scrollDirection")) {
      scrollDirection = map["scrollDirection"];
    }
    return PageView(
      scrollDirection: scrollDirection,
      reverse: map.containsKey("reverse") ? map["reverse"] : false,
      pageSnapping:
          map.containsKey("pageSnapping") ? map["pageSnapping"] : true,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
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

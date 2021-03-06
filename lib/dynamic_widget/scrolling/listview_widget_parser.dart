import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

class ListViewWidgetParser extends WidgetParser {
  String widgetName = "ListView";

  @override
  bool forSerialize(dynamic widget) {
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

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") && "horizontal" == map[""]) {
      scrollDirection = Axis.horizontal;
    }

    var reverse = map.containsKey("reverse") ? map['reverse'] : false;
    var shrinkWrap = map.containsKey("shrinkWrap") ? map["shrinkWrap"] : false;
    var cacheExtent = map.containsKey("cacheExtent") ? map["cacheExtent"] : 0.0;
    var padding = map.containsKey('padding')
        ? parseEdgeInsetsGeometry(map['padding'])
        : null;
    var itemExtent = map.containsKey("itemExtent") ? map["itemExtent"] : null;
    var children = DynamicWidgetBuilder.buildWidgets(
        map['children'], buildContext, listener);
    var pageSize = map.containsKey("pageSize") ? map["pageSize"] : 10;
    var loadMoreUrl =
        map.containsKey("loadMoreUrl") ? map["loadMoreUrl"] : null;
    var isDemo = map.containsKey("isDemo") ? map["isDemo"] : false;

    var params = new ListViewParams(
        scrollDirection,
        reverse,
        shrinkWrap,
        cacheExtent,
        padding,
        itemExtent,
        children,
        pageSize,
        loadMoreUrl,
        isDemo);

    return new ListViewWidget(params, buildContext);
  }
}

class ListViewWidget extends StatefulWidget {
  final ListViewParams _params;
  final BuildContext _buildContext;

  ListViewWidget(this._params, this._buildContext);

  _ListViewWidgetState _state;
  _ListViewWidgetState get state {
    return _state;
  }

  @override
  _ListViewWidgetState createState() {
    if (_state == null) _state = _ListViewWidgetState(_params);
    return _state;
  }
}

class _ListViewWidgetState extends State<ListViewWidget> {
  ListViewParams _params;
  List<Widget> _items = [];

  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  //If there are no more items, it should not try to load more data while scroll
  //to bottom.
  bool loadCompleted = false;

  List<Widget> get items => _items;
  ListViewParams get params => _params;

  _ListViewWidgetState(this._params) {
    if (_params.children != null) {
      _items.addAll(_params.children);
    }
  }

  @override
  void initState() {
    super.initState();
    if (_params.loadMoreUrl == null || _params.loadMoreUrl.isEmpty) {
      loadCompleted = true;
      return;
    }
    _getMoreData();
    _scrollController.addListener(() {
      if (!loadCompleted &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      var jsonString = _params.isDemo ? await fakeRequest() : await doRequest();
      var buildWidgets = DynamicWidgetBuilder.buildWidgets(
          jsonDecode(jsonString), widget._buildContext, null);
      setState(() {
        if (buildWidgets.isEmpty) {
          loadCompleted = true;
        }
        _items.addAll(buildWidgets);
        isPerformingRequest = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: _params.scrollDirection,
      reverse: _params.reverse,
      shrinkWrap: _params.shrinkWrap,
      cacheExtent: _params.cacheExtent,
      padding: _params.padding,
      itemCount: loadCompleted ? _items.length : _items.length + 1,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _buildProgressIndicator();
        } else {
          return _items[index];
        }
      },
      controller: _scrollController,
    );
  }

  fakeRequest() async {
// 如果对Future不熟悉，可以参考 https://juejin.im/post/5b2c67a351882574a756f2eb
    return Future.delayed(Duration(seconds: 2), () {
      return """
[
    {
      "type": "AssetImage",
      "name": "assets/images/burger.jpg"
    },
    {
      "type": "AssetImage",
      "name": "assets/images/burger.jpg"
    },
    {
      "type": "AssetImage",
      "name": "assets/images/burger.jpg"
    },
    {
      "type": "AssetImage",
      "name": "assets/images/burger.jpg"
    },
    {
      "type": "AssetImage",
      "name": "assets/images/burger.jpg"
    }
]          
      """;
    });
  }

  doRequest() async {
    // Await the http get response, then decode the json-formatted responce.
    try {
      var response = await http.get(Uri.parse(getLoadMoreUrl(
          _params.loadMoreUrl, _items.length, _params.pageSize)));
      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception catch (e) {
      print(e);
    }
    return "";
  }
}

class ListViewParams {
  Axis scrollDirection;
  bool reverse;
  bool shrinkWrap;
  double cacheExtent;
  EdgeInsetsGeometry padding;
  double itemExtent;
  List<Widget> children;

  int pageSize;
  String loadMoreUrl;
  //use for demo, if true, it will do the fake request.
  bool isDemo;

  ListViewParams(
      this.scrollDirection,
      this.reverse,
      this.shrinkWrap,
      this.cacheExtent,
      this.padding,
      this.itemExtent,
      this.children,
      this.pageSize,
      this.loadMoreUrl,
      this.isDemo);
}

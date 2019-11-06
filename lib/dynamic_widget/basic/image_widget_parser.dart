import 'dart:ui';
import 'dart:io';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

class AssetImageWidgetParser extends WidgetParser {
  final String widgetName = "AssetImage";

  @override
  bool forSerialize(dynamic widget) {
    return widget is Image && widget.image is AssetImage;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Image asset = widget as Image;

    Map<String, dynamic> map = {
      'name': (asset.image as AssetImage).assetName,
      'semanticLabel': asset.semanticLabel,
      'excludeFromSemantics': asset.excludeFromSemantics,
      'width': asset.width,
      'height': asset.height,
      'scale': (asset.image is ExactAssetImage)
          ? (asset.image as ExactAssetImage).scale
          : null,
      'boxFit': serializeBoxFit(asset.fit),
      'blendMode': serializeBlendMode(asset.colorBlendMode),
      'alignment': serializeAlignment(asset.alignment),
      'repeat': serializeImageRepeat(asset.repeat),
      'centerSlice': serializeRect(asset.centerSlice),
      'matchTextDirection': asset.matchTextDirection,
      'gaplessPlayback': asset.gaplessPlayback,
      'filterQuality': serializeFilterQuality(asset.filterQuality),
    };

    return map;
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    String name = map['name'];
    String semanticLabel =
        map.containsKey('semanticLabel') ? map['semanticLabel'] : null;
    bool excludeFromSemantics = map.containsKey('excludeFromSemantics')
        ? map['excludeFromSemantics']
        : false;
    double scale = map.containsKey("scale") ? map['scale'] : null;
    double width = map.containsKey('width') ? map['width'] : null;
    double height = map.containsKey('height') ? map['height'] : null;
    Color color = map.containsKey('color') ? parseHexColor(map['color']) : null;
    BlendMode blendMode =
        map.containsKey('blendMode') ? parseBlendMode(map['blendMode']) : null;
    BoxFit boxFit =
        map.containsKey('boxFit') ? parseBoxFit(map['boxFit']) : null;
    Alignment alignment = map.containsKey('alignment')
        ? parseAlignment(map['alignment'])
        : Alignment.center;
    ImageRepeat repeat = map.containsKey('repeat')
        ? parseImageRepeat(map['repeat'])
        : ImageRepeat.noRepeat;
    Rect centerSlice =
        map.containsKey('centerSlice') ? parseRect(map['centerSlice']) : null;
    bool matchTextDirection = map.containsKey('matchTextDirection')
        ? map['matchTextDirection']
        : false;
    bool gaplessPlayback =
        map.containsKey('gaplessPlayback') ? map['gaplessPlayback'] : false;
    FilterQuality filterQuality = map.containsKey('filterQuality')
        ? parseFilterQuality(map['filterQuality'])
        : FilterQuality.low;

    String clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var widget = Image.asset(
      name,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: blendMode,
      fit: boxFit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }
}

class NetworkImageWidgetParser extends WidgetParser {
  final String widgetName = "NetworkImage";

  @override
  bool forSerialize(dynamic widget) {
    return widget is Image && widget.image is NetworkImage;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Image asset = widget as Image;

    Map<String, dynamic> map = {
      'src': (asset.image as NetworkImage).url,
      'semanticLabel': asset.semanticLabel,
      'excludeFromSemantics': asset.excludeFromSemantics,
      'width': asset.width,
      'height': asset.height,
      'scale': (asset.image as NetworkImage).scale,
      'boxFit': serializeBoxFit(asset.fit),
      'blendMode': serializeBlendMode(asset.colorBlendMode),
      'alignment': serializeAlignment(asset.alignment),
      'repeat': serializeImageRepeat(asset.repeat),
      'centerSlice': serializeRect(asset.centerSlice),
      'matchTextDirection': asset.matchTextDirection,
      'gaplessPlayback': asset.gaplessPlayback,
      'filterQuality': serializeFilterQuality(asset.filterQuality),
    };

    return map;
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    String src = map['src'];
    String semanticLabel =
        map.containsKey('semanticLabel') ? map['semanticLabel'] : null;
    bool excludeFromSemantics = map.containsKey('excludeFromSemantics')
        ? map['excludeFromSemantics']
        : false;
    double scale = map.containsKey("scale") ? map['scale'] : 1.0;
    double width = map.containsKey('width') ? map['width'] : null;
    double height = map.containsKey('height') ? map['height'] : null;
    Color color = map.containsKey('color') ? parseHexColor(map['color']) : null;
    BlendMode blendMode =
        map.containsKey('blendMode') ? parseBlendMode(map['blendMode']) : null;
    BoxFit boxFit =
        map.containsKey('boxFit') ? parseBoxFit(map['boxFit']) : null;
    Alignment alignment = map.containsKey('alignment')
        ? parseAlignment(map['alignment'])
        : Alignment.center;
    ImageRepeat repeat = map.containsKey('repeat')
        ? parseImageRepeat(map['repeat'])
        : ImageRepeat.noRepeat;
    Rect centerSlice =
        map.containsKey('centerSlice') ? parseRect(map['centerSlice']) : null;
    bool matchTextDirection = map.containsKey('matchTextDirection')
        ? map['matchTextDirection']
        : false;
    bool gaplessPlayback =
        map.containsKey('gaplessPlayback') ? map['gaplessPlayback'] : false;
    FilterQuality filterQuality = map.containsKey('filterQuality')
        ? parseFilterQuality(map['filterQuality'])
        : FilterQuality.low;

    String clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var widget = Image.network(
      src,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: blendMode,
      fit: boxFit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }
}

class FileImageWidgetParser extends WidgetParser {
  final String widgetName = "FileImage";

  @override
  bool forSerialize(dynamic widget) {
    return widget is Image && widget.image is FileImage;
  }

  @override
  Map<String, dynamic> serialize(Widget widget) {
    Image asset = widget as Image;

    Map<String, dynamic> map = {
      'src': (asset.image as FileImage).file.path,
      'semanticLabel': asset.semanticLabel,
      'excludeFromSemantics': asset.excludeFromSemantics,
      'width': asset.width,
      'height': asset.height,
      'scale': (asset.image as FileImage).scale,
      'boxFit': serializeBoxFit(asset.fit),
      'blendMode': serializeBlendMode(asset.colorBlendMode),
      'alignment': serializeAlignment(asset.alignment),
      'repeat': serializeImageRepeat(asset.repeat),
      'centerSlice': serializeRect(asset.centerSlice),
      'matchTextDirection': asset.matchTextDirection,
      'gaplessPlayback': asset.gaplessPlayback,
      'filterQuality': serializeFilterQuality(asset.filterQuality),
    };

    return map;
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener listener) {
    String src = map['src'];
    String semanticLabel =
        map.containsKey('semanticLabel') ? map['semanticLabel'] : null;
    bool excludeFromSemantics = map.containsKey('excludeFromSemantics')
        ? map['excludeFromSemantics']
        : false;
    double scale = map.containsKey("scale") ? map['scale'] : 1.0;
    double width = map.containsKey('width') ? map['width'] : null;
    double height = map.containsKey('height') ? map['height'] : null;
    Color color = map.containsKey('color') ? parseHexColor(map['color']) : null;
    BlendMode blendMode =
        map.containsKey('blendMode') ? parseBlendMode(map['blendMode']) : null;
    BoxFit boxFit =
        map.containsKey('boxFit') ? parseBoxFit(map['boxFit']) : null;
    Alignment alignment = map.containsKey('alignment')
        ? parseAlignment(map['alignment'])
        : Alignment.center;
    ImageRepeat repeat = map.containsKey('repeat')
        ? parseImageRepeat(map['repeat'])
        : ImageRepeat.noRepeat;
    Rect centerSlice =
        map.containsKey('centerSlice') ? parseRect(map['centerSlice']) : null;
    bool matchTextDirection = map.containsKey('matchTextDirection')
        ? map['matchTextDirection']
        : false;
    bool gaplessPlayback =
        map.containsKey('gaplessPlayback') ? map['gaplessPlayback'] : false;
    FilterQuality filterQuality = map.containsKey('filterQuality')
        ? parseFilterQuality(map['filterQuality'])
        : FilterQuality.low;

    String clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var widget = Image.file(
      File(src),
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: blendMode,
      fit: boxFit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }
}

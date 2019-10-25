import '../../dynamic_widget.dart';
import '../utils.dart';
import 'package:flutter/widgets.dart';

class AssetImageWidgetSerializer extends WidgetSerializer {
  String widgetName = "AssetImage";
  @override
  bool forWidget(Widget widget) {
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
}

class NetworkImageWidgetSerializer extends WidgetSerializer {
  String widgetName = "NetworkImage";

  @override
  bool forWidget(Widget widget) {
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
}

class FileImageWidgetSerializer extends WidgetSerializer {
  String widgetName = "FileImage";

  @override
  bool forWidget(Widget widget) {
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
}

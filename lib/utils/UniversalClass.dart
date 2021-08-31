import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

///hexa decimal color
Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
    return Color(int.parse("0x$hexColor"));
  } else {
    return Color(int.parse("0x$hexColor"));
  }
}

///cache network image
getCatchenewtworkImage(String url, double _height, double _width) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    height: _height,
    width: _width,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
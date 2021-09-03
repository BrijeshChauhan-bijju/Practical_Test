import 'dart:io';

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

// Checks Internet connection
Future<bool> hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (_) {
    return false;
  }
}

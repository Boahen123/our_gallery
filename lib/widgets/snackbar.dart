import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';

SnackBar snackBar({required String content, required double? deviceWidth}) {
  return SnackBar(
    content: Text(
      content,
      style: const TextStyle(fontWeight: FontWeight.w700),
    ),
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    backgroundColor: themeColors[0],
    padding: const EdgeInsets.all(10.0),
    width: deviceWidth! * 0.7,
  );
}

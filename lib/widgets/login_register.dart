import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';

/// action button widget for login and register screens
Widget actionButton(double? deviceHeight, double? deviceWidth,
    void Function()? loginUser, String action) {
  return MaterialButton(
    onPressed: loginUser!,
    minWidth: deviceWidth! * 0.70,
    height: deviceHeight! * 0.06,
    color: themeColors[0],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    child: Text(
      action,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';

Widget title(String title) {
  return Column(
    children: [
      Text(
        'Our Gallery',
        style: TextStyle(
          color: themeColors[0],
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        title,
        style: TextStyle(
          color: themeColors[0],
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

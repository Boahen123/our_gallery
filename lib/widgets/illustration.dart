import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

/// Returns an illustration widget
Widget illustration(String image, double? deviceHeight) {
  return Container(
    height: deviceHeight! * 0.3095,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: Svg('assets/images/$image', size: const Size(120, 100)),
        fit: BoxFit.contain,
      ),
    ),
  );
}

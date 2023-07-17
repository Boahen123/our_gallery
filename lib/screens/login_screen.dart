import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Container(
              // color: Colors.white,
              child: Column(children: <Widget>[
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: Svg('assets/images/register.svg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_deviceWidth! * 0.3),
          ),
          child: Container(
            color: themeColors[0],
            height: _deviceHeight! * 0.6905,
          ),
        ),
      ]))),
    );
  }
}

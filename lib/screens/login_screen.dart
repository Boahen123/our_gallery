import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'formKey');
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
              child: Column(children: <Widget>[
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: Svg('assets/images/register.svg', size: Size(120, 100)),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_deviceWidth! * 0.3),
            ),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          height: _deviceHeight! * 0.6905,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _title(),
              _loginForm(),
              _loginButton(),
            ],
          )),
        ),
      ]))),
    );
  }

  Widget _title() {
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
          'Login',
          style: TextStyle(
            color: themeColors[0],
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 0.20,
      child: const Form(
          child: Column(
        children: [],
      )),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: () {},
      minWidth: _deviceWidth! * 0.70,
      height: _deviceHeight! * 0.06,
      color: themeColors[0],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}

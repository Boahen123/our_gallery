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
  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: Svg('assets/images/register.svg',
                          size: Size(120, 100)),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: _deviceHeight! * 0.04,
                    ),
                    _title(),
                    _loginForm(),
                    SizedBox(
                      height: _deviceHeight! * 0.04,
                    ),
                    _loginButton(),
                  ],
                )),
              ),
            ]))),
      ),
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
    return SizedBox(
      height: _deviceHeight! * 0.20,
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _emailTextField(),
              _passwordTextField(),
            ],
          )),
    );
  }

  Widget _emailTextField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Email..',
          prefixIcon: Icon(Icons.email),
        ),
        onSaved: (String? value) {
          setState(() {
            _email = value;
          });
        },
        validator: (String? value) {
          bool result =
              RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                  .hasMatch(value!);
          return result ? null : 'Please enter a valid email';
        },
      ),
    );
  }

  Widget _passwordTextField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          hintText: 'Password..',
          prefixIcon: Icon(Icons.lock),
        ),
        onSaved: (String? value) {
          setState(() {
            _password = value;
          });
        },
        validator: (String? value) {
          return value!.length < 6
              ? 'Password must be at least 6 characters'
              : null;
        },
      ),
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      onPressed: _loginUser,
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

  void _loginUser() {
    print(_formKey.currentState!.validate());
    if (_formKey.currentState!.validate()) {}
  }
}

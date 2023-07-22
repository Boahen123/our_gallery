import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';
import 'package:our_gallery/services/firebase_service.dart';
import 'package:our_gallery/widgets/illustration.dart';
import 'package:our_gallery/widgets/login_register.dart';
import 'package:our_gallery/widgets/title.dart';
import 'package:get_it/get_it.dart';

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
  bool obscureText = true;

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.I.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(children: <Widget>[
          Flexible(flex: 1, child: illustration('login.svg', _deviceHeight)),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_deviceWidth! * 0.3),
                ),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              // height: _deviceHeight! * 0.6905,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: _deviceHeight! * 0.04,
                  ),
                  title('Login'),
                  _loginForm(),
                  SizedBox(
                    height: _deviceHeight! * 0.04,
                  ),
                  actionButton(
                      _deviceHeight, _deviceWidth, _loginUser, 'Login'),
                  SizedBox(
                    height: _deviceHeight! * 0.04,
                  ),
                  _registerScreenLink(),
                ],
              )),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
        decoration: InputDecoration(
          hintText: 'Email..',
          prefixIcon: Icon(
            Icons.email,
            color: themeColors[0],
          ),
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
        obscureText: obscureText,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          hintText: 'Password..',
          prefixIcon: Icon(
            Icons.lock,
            color: themeColors[0],
          ),
          suffixIcon: IconButton(
            icon: obscureText
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
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

  Widget _registerScreenLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        "Don't have an account?",
        style: TextStyle(
            color: themeColors[0], fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool result = await _firebaseService!
          .loginUser(emailAddress: _email!, password: _password!);
      if (result) {
        Navigator.popAndPushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

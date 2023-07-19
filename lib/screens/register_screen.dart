import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:our_gallery/widgets/login_register.dart';
import 'package:our_gallery/widgets/title.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double? _deviceHeight, _deviceWidth;
  final GlobalKey<FormState> _registrationFormKey =
      GlobalKey<FormState>(debugLabel: 'registrationformKey');
  String? _name, _email, _password;
  bool obscureText = true;
  File? _profileImage;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(children: <Widget>[
                Container(
                  height: _deviceHeight! * 0.2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: Svg('assets/images/register.svg',
                          size: Size(120, 100)),
                      fit: BoxFit.contain,
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
                  height: _deviceHeight! * 0.75,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: _deviceHeight! * 0.01,
                      ),
                      title('Sign Up'),
                      SizedBox(
                        height: _deviceHeight! * 0.01,
                      ),
                      _profileImageWidget(),
                      _registrationForm(),
                      actionButton(_deviceHeight, _deviceWidth, _registerUser,
                          'Sign Up'),
                    ],
                  )),
                ),
              ]),
            ),
          )),
    ));
  }

  Widget _registrationForm() {
    return SizedBox(
      child: Form(
          key: _registrationFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _nameText(),
              _emailText(),
              _passwordText(),
              SizedBox(
                height: _deviceHeight! * 0.04,
              )
            ],
          )),
    );
  }

  Widget _profileImageWidget() {
    var imageProvider = _profileImage != null
        ? FileImage(_profileImage!)
        : const Svg('assets/images/register.svg', size: Size(120, 100));
    return GestureDetector(
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            setState(() {
              _profileImage = File(result.files.first.path!);
            });
          }
        },
        child: CircleAvatar(
          radius: 50,
          backgroundImage: imageProvider as ImageProvider,
        ));
  }

  Widget _nameText() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      child: Flexible(
        child: TextFormField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                hintText: 'Name..',
                prefixIcon: Icon(
                  Icons.person,
                  color: themeColors[0],
                )),
            validator: (value) =>
                value!.isEmpty ? 'Name cannot be empty' : null,
            onSaved: (value) {
              setState(() {
                _name = value;
              });
            }),
      ),
    );
  }

  Widget _emailText() {
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

  Widget _passwordText() {
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

  void _registerUser() {
    if (_registrationFormKey.currentState!.validate() &&
        _profileImage != null) {
      _registrationFormKey.currentState!.save();
      print('Name: $_name');
      print('Email: $_email');
      print('Password: $_password');
    }
  }
}

import 'package:flutter/material.dart';
// import 'package:our_gallery/data/theme_colors.dart';
import 'package:our_gallery/screens/login_screen.dart';
import 'package:our_gallery/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) =>
            const SafeArea(child: RegisterScreen()),
        '/login': (BuildContext context) => const LoginScreen(),
      },
      title: 'Our Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
    );
  }
}

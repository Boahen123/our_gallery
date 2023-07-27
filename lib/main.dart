import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:our_gallery/screens/home_screen.dart';
import 'package:our_gallery/screens/login_screen.dart';
import 'package:our_gallery/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:our_gallery/services/firebase_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
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
        '/login': (BuildContext context) =>
            const SafeArea(child: LoginScreen()),
        '/home': (BuildContext context) => const SafeArea(child: HomeScreen())
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

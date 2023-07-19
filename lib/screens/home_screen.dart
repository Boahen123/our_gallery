import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? _deviceHeight;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight! * 0.08,
        title: const Text(
          'Our Gallery',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: themeColors[0],
        actions: [
          IconButton(
              iconSize: _deviceHeight! * 0.03,
              onPressed: () {},
              icon: const Icon(
                Icons.add_a_photo,
                color: Colors.white,
              )),
          IconButton(
              iconSize: _deviceHeight! * 0.03,
              onPressed: () {},
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}

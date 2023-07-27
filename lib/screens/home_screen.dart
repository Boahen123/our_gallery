import 'package:flutter/material.dart';
import 'package:our_gallery/data/theme_colors.dart';
import 'package:our_gallery/screens/feed_screen.dart';
import 'package:our_gallery/screens/profile_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:our_gallery/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? _deviceHeight;
  List<PopupMenuEntry<String>> options = [
    const PopupMenuItem<String>(
      value: 'item 1',
      child: Text('Item 1'),
    ),
  ];
  String? selectedOption;
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const FeedScreen(),
    const ProfileScreen(),
  ];
  File? _addedImage;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.I.get<FirebaseService>();
  }

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
                tooltip: 'Add a photo',
                onPressed: _addImage,
                icon: const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                )),
            IconButton(
                iconSize: _deviceHeight! * 0.03,
                tooltip: 'log out',
                onPressed: () async {
                  await _firebaseService!.logout();
                  if (!mounted) return;
                  Navigator.popAndPushNamed(context, '/login');
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                )),
            PopupMenuButton<String>(
                color: Colors.white,
                iconSize: _deviceHeight! * 0.03,
                initialValue: selectedOption,
                tooltip: 'More options',
                onSelected: (String item) {
                  setState(() {
                    selectedOption = item;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return options;
                }),
          ]),
      bottomNavigationBar: _bottomNavBar(),
      body: _pages[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addImage() async {
    // var imageProvider = _addedImage != null
    //     ? FileImage(_addedImage!)
    //     : const Svg('assets/images/register.svg', size: Size(120, 100));
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _addedImage = File(result.files.first.path!);
      });
      await _firebaseService!.addImage(_addedImage!);
    }
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box), label: 'Profile'),
      ],
      backgroundColor: themeColors[0],
      selectedItemColor: Colors.white,
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
    );
  }
}

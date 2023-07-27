import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:our_gallery/data/theme_colors.dart';
import 'package:our_gallery/services/firebase_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double? _deviceHeight, _deviceWidth;
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
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth! * 0.05, vertical: _deviceHeight! * 0.02),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImage(),
            _postGridView(),
          ]),
    );
  }

  Widget _profileImage() {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(_firebaseService!.currentUser!['image']),
      ),
    );
  }

  Widget _postGridView() {
    return Expanded(
        child: StreamBuilder(
      stream: _firebaseService!.getPostsOfUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List posts =
              snapshot.data!.docs.map((element) => element.data()).toList();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index] as Map;
              return Container(
                  decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(post['image'])),
              ));
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: themeColors[0],
                ),
                const Text('loading your posts'),
              ],
            ),
          );
        }
      },
    ));
  }
}

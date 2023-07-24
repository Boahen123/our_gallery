import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:our_gallery/services/firebase_service.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  FirebaseService? _firebaseService;
  double? _deviceHeight, _deviceWidth;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.I.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: _deviceHeight!,
      width: _deviceWidth!,
      child: _postListView(),
    );
  }

  Widget _postListView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firebaseService!.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data!.docs);

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot<Object?> post = snapshot.data!.docs[index];
              return Container(
                margin: EdgeInsets.symmetric(
                    vertical: _deviceHeight! * 0.01,
                    horizontal: _deviceWidth! * 0.05),
                height: _deviceHeight! * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(post['image']),
                  fit: BoxFit.cover,
                )),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

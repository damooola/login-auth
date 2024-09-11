import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // current user
  final user = FirebaseAuth.instance.currentUser!;

//sign user out
  void userSignOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: userSignOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: NetworkImage(user.photoURL ??
                          "https://th.bing.com/th/id/R.e6e5ba63e95200efa5a20649428b258c?rik=QHK4sP9rFm30EQ&pid=ImgRaw&r=0"))),
            ),
            Text(
              "LOGGED IN AS ${user.email}!",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

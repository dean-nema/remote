import 'dart:async';

import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:remote_client/Database/db_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// appId: '1:938446957301:web:92849d2a832d10f9bdb3bc',
// apiKey: 'AIzaSyBgRwUZrLtKNMW7eVRnloxUSvsbgUrkBbk',
// projectId: 'remote-54b9a',
// messagingSenderId: '938446957301',
// authDomain: 'remote-54b9a.firebaseapp.com',

class _HomePageState extends State<HomePage> {
  // Future<void> get() async {
  //   try {
  //     await Database.getData();
  //     flag = true;
  //   } catch (e) {
  //     flag = false;
  //   }
  // }
  String data = "";
  bool flag = false;
  late Timer _timer;
  int a = 0;

// //functions
//   void run(Timer time) {
//     if (a == 0) {
//       try {
//         Database.getData();
//         flag = true;
//       } catch (e) {
//         flag = false;
//         print("fail");
//       }
//       a++;
//     }
//   }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   _timer = Timer.periodic(Duration(milliseconds: 100), Database.getData());
  // }

  @override
  Widget build(BuildContext context) {
    final docRef = Firestore.instance.collection(Database.collection);

    final subscription = docRef.stream.listen((document) {
   //   Firestore.instance.close();
      Database.getData();
    });

    return Center(
      child: Text((flag ? "It worked Damn" : "Waittt I Guess")),
    );
  }
}

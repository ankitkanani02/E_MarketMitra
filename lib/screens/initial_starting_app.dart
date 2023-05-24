import 'package:emmitra/screens/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class InitalStratingApp extends StatelessWidget {
  const InitalStratingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ignore: avoid_print
            print("firebase initaliztion success!");
            return const SignInScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

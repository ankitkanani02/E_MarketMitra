import 'package:emmitra/screens/initial_starting_app.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Market Mitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        // colorScheme:
        //     ColorScheme.fromSwatch().copyWith(secondary: Colors.teal)
      ),
      home: const InitalStratingApp(),
      // const HomeScreen(),
    );
  }
}

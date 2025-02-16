import 'package:flutter/material.dart';
import 'package:flutter_database/database/view/home_user_screen.dart';
import 'package:flutter_database/cam&Map/google_map_screen.dart';
import 'package:flutter_database/home_screen.dart';
import 'package:flutter_database/cam&Map/image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomeUserScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'home.dart';
import 'login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  // FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE); 
  runApp(const MyApp());
}

 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Player',
      theme: ThemeData(
      
        primarySwatch: Colors.amber,
      ),
      home: const LoginPage(),
    );
  }
}


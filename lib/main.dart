import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import '../widgets/rate_list.dart';
import 'package:myapp/screens/registration_screen.dart';
void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'forexechangerates', // Change the title here
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const RegistrationScreen(),
      home: RegistrationForm(), //const Scaffold(
       // body: RateList(), // Wrap RateList in Scaffold
      //),
    );
  }
}

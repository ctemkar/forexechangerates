import 'package:flutter/material.dart';
import '../widgets/rate_list.dart';

void main() {
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
      home: const Scaffold(
        body: RateList(), // Wrap RateList in Scaffold
      ),
    );
  }
}

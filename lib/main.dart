import 'package:flutter/material.dart';
import 'package:google_maps/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Google Maps Demo'),
    );
  }
}


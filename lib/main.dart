
import 'package:flutter/material.dart';
// import googleFonts
// import 'package:google_fonts/google_fonts.dart';
import 'package:yolo/front/login.dart';
import 'package:yolo/front/view/test.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
